import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';
import 'package:pass_the_pigs/ui/common/error_snackbar.dart';
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

  void _handleBankTurn(BuildContext context) {
    final l10n = context.l10n;
    final result = context.read<TurnCalculatorCubit>().bankTurn();

    switch (result) {
      case TurnBanked(:final throws):
        onBankTurn(throws);
      case TurnPigOut():
        showErrorSnackBar(context, l10n.pigOutMessage);
        onPigOut();
      case TurnIncomplete():
        showErrorSnackBar(context, l10n.turnNotComplete);
      case TurnNothingToBank():
        showErrorSnackBar(context, l10n.nothingToBank);
      case TurnContinue():
      case TurnOinker():
        break;
    }
  }

  void _handleCommitRoll(BuildContext context) {
    final l10n = context.l10n;
    final result = context
        .read<TurnCalculatorCubit>()
        .commitRoll(gameScore: player.score);

    switch (result) {
      case TurnContinue():
        break;
      case TurnBanked(:final throws):
        onBankTurn(throws);
      case TurnPigOut():
        showErrorSnackBar(context, l10n.pigOutMessage);
        onPigOut();
      case TurnIncomplete():
        showErrorSnackBar(context, l10n.turnNotComplete);
      case TurnNothingToBank():
      case TurnOinker():
        break;
    }
  }

  void _showScoreboard(BuildContext context) {
    final l10n = context.l10n;
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.scoreboardTitle,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: allPlayers.length,
                  itemBuilder: (context, index) {
                    final boardPlayer = allPlayers[index];
                    return ListTile(
                      selected: boardPlayer.id == player.id,
                      title: Text(boardPlayer.name),
                      trailing: Text('${boardPlayer.score}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showScoreboard(context),
            icon: const Icon(Icons.scoreboard_outlined),
            tooltip: l10n.scoreboardTooltip,
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.logout_rounded),
          tooltip: l10n.endGameTooltip,
          onPressed: () => showDialog<void>(
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
          preferredSize: const Size.fromHeight(28),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              l10n.totalScoreLabel(player.score),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              TurnScoreCard(
                context.select(
                  (TurnCalculatorCubit cubit) => cubit.currentThrow,
                ),
                context.select(
                  (TurnCalculatorCubit cubit) => cubit.getTurnScore(),
                ),
              ),
              const SizedBox(height: 16),
              for (final position in const [
                Position.sideNoSpot,
                Position.sideSpot,
                Position.trotter,
                Position.razorback,
                Position.snouter,
                Position.leaningJowler,
              ]) ...[
                _PositionRow(position: position),
                if (position != Position.leaningJowler)
                  const SizedBox(height: 16),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => _handleCommitRoll(context),
                  icon: const Icon(Icons.replay_rounded),
                  label: Text(l10n.saveAndRollAgain),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.tonalIcon(
                  onPressed: () => _handleBankTurn(context),
                  icon: const Icon(Icons.check_rounded),
                  label: Text(l10n.nextPlayerFab),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.error,
                  ),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (_) => OinkerDialog(
                      onOinker: () {
                        context.read<TurnCalculatorCubit>().resolveOinker();
                        onOinker();
                      },
                    ),
                  ),
                  icon: Image.asset(
                    'assets/images/icons/oinker.gif',
                    height: 20,
                    width: 20,
                  ),
                  label: Text(l10n.makinBaconButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PositionRow extends StatelessWidget {
  const _PositionRow({required this.position});

  final Position position;

  @override
  Widget build(BuildContext context) {
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
}
