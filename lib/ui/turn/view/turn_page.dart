import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/player.dart';
import 'package:pass_the_pigs/ui/turn/cubit/turn_cubit.dart';
import 'package:pass_the_pigs/ui/turn/enums/pig.dart';
import 'package:pass_the_pigs/ui/turn/enums/position.dart';
import 'package:pass_the_pigs/ui/turn/models/turn_action_result.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/choice_button.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/oinker_dialog.dart';
import 'package:pass_the_pigs/ui/turn/view/widgets/turn_score_card.dart';

class TurnCalculatorPage extends StatelessWidget {
  const TurnCalculatorPage({
    super.key,
    required this.onOinker,
    required this.onBankTurn,
    required this.onPigOut,
    required this.player,
    required this.allPlayers,
  });

  final VoidCallback onOinker;
  final VoidCallback onPigOut;
  final void Function(List<Throw> throws) onBankTurn;
  final Player player;
  final List<Player> allPlayers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TurnCalculatorCubit(),
      child: TurnCalculatorView(
        onOinker: onOinker,
        onBankTurn: onBankTurn,
        onPigOut: onPigOut,
        player: player,
        allPlayers: allPlayers,
      ),
    );
  }
}

class TurnCalculatorView extends StatelessWidget {
  const TurnCalculatorView({
    super.key,
    required this.onOinker,
    required this.onBankTurn,
    required this.onPigOut,
    required this.player,
    required this.allPlayers,
  });

  final VoidCallback onOinker;
  final VoidCallback onPigOut;
  final void Function(List<Throw> throws) onBankTurn;
  final Player player;
  final List<Player> allPlayers;

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
          ),
        ),
      ),
    );
  }

  void _handleBankTurn(BuildContext context) {
    final l10n = context.l10n;
    final turnCubit = context.read<TurnCalculatorCubit>();
    final result = turnCubit.bankTurn();

    switch (result) {
      case TurnBanked(:final throws):
        onBankTurn(throws);
      case TurnPigOut():
        _showErrorSnackBar(context, l10n.pigOutMessage);
        onPigOut();
      case TurnIncomplete():
        _showErrorSnackBar(context, l10n.turnNotComplete);
      case TurnNothingToBank():
        _showErrorSnackBar(context, l10n.nothingToBank);
      case TurnContinue():
      case TurnOinker():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'End your turn and save current score',
        label: Text(l10n.nextPlayerFab),
        onPressed: () => _handleBankTurn(context),
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
                      ),
                    ),
                  ],
                );
              },
            ),
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
            'Total score: ${player.score}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: TurnCalculatorViewBody(
            gameScore: player.score,
            onBankTurn: onBankTurn,
            onOinker: () {
              context.read<TurnCalculatorCubit>().resolveOinker();
              onOinker();
            },
            onPigOut: onPigOut,
            showError: (message) => _showErrorSnackBar(context, message),
          ),
        ),
      ),
    );
  }
}

class TurnCalculatorViewBody extends StatelessWidget {
  const TurnCalculatorViewBody({
    super.key,
    required this.gameScore,
    required this.onBankTurn,
    required this.onOinker,
    required this.onPigOut,
    required this.showError,
  });

  final int gameScore;
  final void Function(List<Throw> throws) onBankTurn;
  final VoidCallback onOinker;
  final VoidCallback onPigOut;
  final void Function(String message) showError;

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

  void _handleCommitRoll(BuildContext context) {
    final l10n = context.l10n;
    final result = context
        .read<TurnCalculatorCubit>()
        .commitRoll(gameScore: gameScore);

    switch (result) {
      case TurnContinue():
        break;
      case TurnBanked(:final throws):
        onBankTurn(throws);
      case TurnPigOut():
        showError(l10n.pigOutMessage);
        onPigOut();
      case TurnIncomplete():
        showError(l10n.turnNotComplete);
      case TurnNothingToBank():
      case TurnOinker():
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final turnScore =
        context.select((TurnCalculatorCubit cubit) => cubit.getTurnScore());
    final currentThrow =
        context.select((TurnCalculatorCubit cubit) => cubit.currentThrow);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _handleCommitRoll(context),
                      label: Text(l10n.saveAndRollAgain),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                        builder: (_) => OinkerDialog(onOinker: onOinker),
                      ),
                      icon: Image.asset('assets/images/icons/oinker.gif'),
                      label: Text(l10n.makinBacon),
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
