import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';
import 'package:pass_the_pigs/ui/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/making_bacon_dialog.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/turn_score_card.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/choice_button.dart';

class TurnCalculatorPage extends StatelessWidget {
  const TurnCalculatorPage(
      {super.key,
      required this.onOffTheTable,
      required this.goToNextPlayer,
      required this.player,
      required this.allPlayers});
  final VoidCallback onOffTheTable;
  final Function goToNextPlayer;
  final Player player;
  final List<Player> allPlayers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TurnCalculatorCubit(),
      child: TurnCalculatorView(
        onOffTheTable: onOffTheTable,
        goToNextPlayer: goToNextPlayer,
        player: player,
        allPlayers: allPlayers,
      ),
    );
  }
}

class TurnCalculatorView extends StatelessWidget {
  const TurnCalculatorView(
      {super.key,
      required this.goToNextPlayer,
      required this.onOffTheTable,
      required this.player,
      required this.allPlayers});
  final VoidCallback onOffTheTable;
  final Function goToNextPlayer;
  final Player player;
  final List<Player> allPlayers;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'End your turn and save current score',
        label: Text(l10n.nextPlayerFab),
        onPressed: () {
          final currentThrow = context.read<TurnCalculatorCubit>().currentThrow;

          if (currentThrow.isThrowComplete) {
            final turnCubit = context.read<TurnCalculatorCubit>();
            turnCubit.saveThrowToTurnAndResetThrow();

            final throwsInTurn = context.read<TurnCalculatorCubit>().state;
            goToNextPlayer(throwsInTurn);
            turnCubit.resetTurn();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                content: Text(
                  l10n.turnNotComplete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            );
          }
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
                context: context,
                isDismissible: true,
                enableDrag: true,
                builder: (context) {
                  return Column(
                    children: [
                      AppBar(
                        title: const Text('Scoreboard'),
                        centerTitle: true,
                        leading: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: allPlayers.length,
                        itemBuilder: (context, index) => ListTile(
                          selected: allPlayers[index].id == player.id,
                          title: Text(allPlayers[index].name),
                          trailing: Text(
                            allPlayers[index].score.toString(),
                          ),
                        ),
                      ))
                    ],
                  );
                }),
            icon: const Icon(Icons.scoreboard_outlined),
            tooltip: 'Open scoreboard',
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded),
          tooltip: 'End game',
          onPressed: () => showDialog(
            context: context,
            builder: (_) => DestructiveDialog(
              destroyButtonText: l10n.endGameConfirmButton,
              onConfirm: () {
                Navigator.of(context).pop();
                context.read<GameCubit>().endGame();
              },
              title: l10n.endGameDialogTitle,
              content: l10n.endGameDialogContent,
              onCancel: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(player.name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Text(
            'Current score: ${player.score}',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: TurnCalculatorViewBody(() {
            final state = context.read<TurnCalculatorCubit>();
            state.resetCurrentThrow();
            onOffTheTable();
          }),
        ),
      ),
    );
  }
}

class TurnCalculatorViewBody extends StatelessWidget {
  const TurnCalculatorViewBody(this.onOffTheTable, {super.key});
  final VoidCallback onOffTheTable;
  Row _buildRow(Position position) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ChoiceButton(
          pig: Pig.one,
          valueOfButton: position,
        ),
        Image.asset(position.assetPath),
        ChoiceButton(
          pig: Pig.two,
          valueOfButton: position,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final turnScore =
        context.select((TurnCalculatorCubit cubit) => cubit.getTurnScore());
    final currentThrow =
        context.select((TurnCalculatorCubit cubit) => cubit.currentThrow);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TurnScoreCard(currentThrow, turnScore),
          const SizedBox(height: 16),
          Column(
            children: [
              _buildRow(Position.sideNoSpot),
              _buildRow(Position.sideSpot),
              _buildRow(Position.trotter),
              _buildRow(Position.razorback),
              _buildRow(Position.snouter),
              _buildRow(Position.leaningJowler),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        context.read<TurnCalculatorCubit>().resetTurn();
                        context.read<GameCubit>().nextPlayer();
                      },
                      icon: Image.asset('assets/images/icons/oinker.gif'),
                      label: Text(l10n.makingBacon),
                    ),
                  ),
                ],
              ),
              SizedBox.fromSize(
                size: const Size.fromHeight(8),
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (currentThrow.isThrowComplete) {
                          context
                              .read<TurnCalculatorCubit>()
                              .saveThrowToTurnAndResetThrow();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.fixed,
                              backgroundColor:
                                  Theme.of(context).colorScheme.errorContainer,
                              content: Text(
                                l10n.turnNotComplete,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      label: const Text('Save and roll again'),
                    ),
                  ),
                ],
              ),
              SizedBox.fromSize(
                size: const Size.fromHeight(8),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.error,
                          width: 1,
                        ),
                        foregroundColor: Theme.of(context).colorScheme.onError,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        surfaceTintColor:
                            Theme.of(context).colorScheme.surfaceTint,
                      ),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) =>
                            OffTheTableDialog(onOffTheTable: onOffTheTable),
                      ),
                      // icon: Image.asset('assets/images/icons/oinker.gif'),
                      label: Text(l10n.offTheTable),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
