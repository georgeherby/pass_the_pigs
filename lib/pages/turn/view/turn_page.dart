import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/pages/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/pages/game/models/player.dart';
import 'package:pass_the_pigs/pages/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/pages/turn/enums/pig.dart';
import 'package:pass_the_pigs/pages/turn/enums/position.dart';
import 'package:pass_the_pigs/pages/turn/view/widgets/making_bacon_dialog.dart';
import 'package:pass_the_pigs/pages/turn/view/widgets/turn_score_card.dart';
import 'package:pass_the_pigs/pages/turn/view/widgets/choice_button.dart';

class TurnCalculatorPage extends StatelessWidget {
  const TurnCalculatorPage(
      {super.key,
      required this.onMakingBacon,
      required this.goToNextPlayer,
      required this.player,
      required this.allPlayers});
  final VoidCallback onMakingBacon;
  final Function goToNextPlayer;
  final Player player;
  final List<Player> allPlayers;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TurnCalculatorCubit(),
      child: TurnCalculatorView(
          onMakingBacon: onMakingBacon,
          goToNextPlayer: goToNextPlayer,
          player: player,
          allPlayers: allPlayers),
    );
  }
}

class TurnCalculatorView extends StatelessWidget {
  const TurnCalculatorView(
      {super.key,
      required this.goToNextPlayer,
      required this.onMakingBacon,
      required this.player,
      required this.allPlayers});
  final VoidCallback onMakingBacon;
  final Function goToNextPlayer;
  final Player player;
  final List<Player> allPlayers;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(l10n.nextPlayerFab),
        onPressed: () {
          final state = context.read<TurnCalculatorCubit>().state;

          if (state.isTurnComplete) {
            goToNextPlayer(state);
            context.read<TurnCalculatorCubit>().reset();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.fixed,
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                content: Text(
                  l10n.turnNotComplete,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                )));
          }
        },
        icon: const Icon(Icons.arrow_forward_rounded),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
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
                      ...List.generate(
                          allPlayers.length,
                          (index) => ListTile(
                                selected: allPlayers[index].id == player.id,
                                title: Text(allPlayers[index].name),
                                trailing:
                                    Text(allPlayers[index].score.toString()),
                              ))
                    ],
                  );
                }),
            icon: const Icon(Icons.scoreboard_outlined),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.read<GameCubit>().endGame(),
        ),
        centerTitle: true,
        title: Text(player.name),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Text(
            'Current score: ${player.score}',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
      ),
      body: Center(child: TurnCalculatorViewBody(onMakingBacon)),
    );
  }
}

class TurnCalculatorViewBody extends StatelessWidget {
  const TurnCalculatorViewBody(this.onMakingBacon, {super.key});
  final VoidCallback onMakingBacon;
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
    final turn = context.select((TurnCalculatorCubit cubit) => cubit.state);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TurnScoreCard(turn),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                            width: 1,
                          ),
                          foregroundColor: Theme.of(context).colorScheme.error,
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
                          surfaceTintColor:
                              Theme.of(context).colorScheme.surfaceTint,
                          // backgroundColor:
                          //     Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        onPressed: () => showPlatformDialog(
                            context: context,
                            builder: (_) => MakingBaconDialog(
                                onMakingBacon: onMakingBacon)),
                        icon: Image.asset('assets/images/icons/oinker.gif'),
                        label: Text(l10n.makingBacon)),
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
