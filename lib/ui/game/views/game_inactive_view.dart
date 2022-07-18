import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';

import 'package:pass_the_pigs/ui/game/views/widgets/add_player_form.dart';

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
                l10n.appBarTitle.toUpperCase(),
                style: GoogleFonts.dmSerifDisplay(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Theme.of(context).colorScheme.outline,
                ),
              ),
              Text(
                l10n.appBarTitle.toUpperCase(),
                style: GoogleFonts.dmSerifDisplay(
                  color: lightColorScheme.secondaryContainer,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              return context.read<GameCubit>().state.players.length >= 2
                  ? context.read<GameCubit>().startGame()
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor:
                          Theme.of(context).colorScheme.errorContainer,
                      content: Text(
                        l10n.minimumOfTwoPlayers,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      )));
            },
            icon: const Icon(Icons.start_rounded),
            label: Text(l10n.startGameButton)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AddPlayerForm(
                onSubmit: (name) => context.read<GameCubit>().addPlayer(name),
              ),
              BlocBuilder<GameCubit, Game>(
                builder: (context, state) {
                  debugPrint(state.players.length.toString());

                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.players.length,
                      itemBuilder: (context, index) {
                        final player = state.players[index];
                        return ListTile(
                          title: Text(player.name),
                          trailing: IconButton(
                              onPressed: () => context
                                  .read<GameCubit>()
                                  .removePlayer(player.id),
                              icon: const Icon(Icons.delete_rounded)),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
