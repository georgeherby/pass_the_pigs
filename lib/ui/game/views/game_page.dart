import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/views/game_inactive_view.dart';
import 'package:pass_the_pigs/ui/game/views/game_winner_view.dart';
import 'package:pass_the_pigs/ui/turn/view/turn_page.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocProvider(
        create: (_) => GameCubit(),
        child: const GameView(),
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, Game>(
      builder: (context, state) {
        debugPrint('GameView state: ${state.hasWinner}');
        if (state.isGameActive && !state.hasWinner) {
          debugPrint(state.toString());
          return TurnCalculatorPage(
            onMakingBacon: () {
              context.read<GameCubit>().makingBacon();
              context.read<GameCubit>().nextPlayer();
            },
            allPlayers: state.players,
            player: state.players[state.currentPlayer],
            goToNextPlayer: (Throw throwToAdd) {
              context.read<GameCubit>().addThrowToPlayer(throwToAdd);
              if (!context.read<GameCubit>().state.hasWinner) {
                debugPrint('No winner do continue to next player');
                context.read<GameCubit>().nextPlayer();
              } else {
                debugPrint('Game is over');
              }
            },
          );
        } else if (state.isGameActive && state.hasWinner) {
          return GameWinnerView(
              winnerName:
                  '${context.read<GameCubit>().state.players[context.read<GameCubit>().state.currentPlayer].name} wins!');
        } else {
          return const GameInactiveView();
        }
      },
    );
  }
}
