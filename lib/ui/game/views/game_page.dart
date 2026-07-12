import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/storage/game_storage.dart';
import 'package:pass_the_pigs/ui/game/views/game_inactive_view.dart';
import 'package:pass_the_pigs/ui/game/views/game_winner_view.dart';
import 'package:pass_the_pigs/ui/turn/view/turn_page.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.gameStorage,
    required this.initialGame,
  });

  final GameStorage gameStorage;
  final Game initialGame;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameCubit(
        storage: gameStorage,
        initialGame: initialGame,
      ),
      child: const GameView(),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, Game>(
      builder: (context, state) {
        if (state.isGameActive && !state.hasWinner) {
          return TurnCalculatorPage(
            onOinker: () {
              context.read<GameCubit>().resetAllThrows();
              context.read<GameCubit>().nextPlayer();
            },
            allPlayers: state.players,
            player: state.players[state.currentPlayer],
            onBankTurn: (List<Throw> throwsToAdd) {
              context.read<GameCubit>().addTurnToPlayer(throwsToAdd);
              if (!context.read<GameCubit>().state.hasWinner) {
                context.read<GameCubit>().nextPlayer();
              }
            },
            onPigOut: () {
              context.read<GameCubit>().nextPlayer();
            },
          );
        } else if (state.isGameActive && state.hasWinner) {
          final player = state.players[state.currentPlayer];
          return GameWinnerView(score: player.score, winnerName: player.name);
        } else {
          return const GameInactiveView();
        }
      },
    );
  }
}
