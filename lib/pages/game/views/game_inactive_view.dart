import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/pages/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/pages/game/models/player.dart';

class GameInactiveView extends StatelessWidget {
  const GameInactiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Stack(
            children: [
              Text(
                l10n.counterAppBarTitle.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Theme.of(context).colorScheme.outline,
                ),
              ),
              Text(
                l10n.counterAppBarTitle.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                context.read<GameCubit>().addPlayer(const Player(
                      id: 0,
                      name: 'George',
                      throws: [],
                    ));
                context.read<GameCubit>().addPlayer(
                      const Player(
                        id: 1,
                        name: 'Natalie',
                        throws: [],
                      ),
                    );
                context.read<GameCubit>().addPlayer(
                      const Player(
                        id: 2,
                        name: 'Ruth',
                        throws: [],
                      ),
                    );
                context.read<GameCubit>().startGame();
              },
              child: const Text('Start game')),
        ));
  }
}
