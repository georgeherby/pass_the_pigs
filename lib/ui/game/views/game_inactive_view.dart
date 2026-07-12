import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';
import 'package:pass_the_pigs/ui/common/error_snackbar.dart';
import 'package:pass_the_pigs/ui/game/cubit/game_cubit.dart';
import 'package:pass_the_pigs/ui/game/models/game.dart';
import 'package:pass_the_pigs/ui/game/views/widgets/add_player_form.dart';

class GameInactiveView extends StatelessWidget {
  const GameInactiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

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
                  ..color = colorScheme.outline,
              ),
            ),
            Text(
              l10n.appBarTitle.toUpperCase(),
              style: GoogleFonts.dmSerifDisplay(
                color: colorScheme.secondaryContainer,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Column(
                children: [
                  AddPlayerForm(
                    onSubmit: (name) =>
                        context.read<GameCubit>().addPlayer(name),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<GameCubit, Game>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: state.players.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 4),
                          itemBuilder: (context, index) {
                            final player = state.players[index];
                            return Material(
                              color: colorScheme.surfaceContainerHigh,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(appRadius),
                              child: ListTile(
                                title: Text(player.name),
                                trailing: IconButton(
                                  onPressed: () => context
                                      .read<GameCubit>()
                                      .removePlayer(player.id),
                                  icon: const Icon(Icons.delete_rounded),
                                  tooltip: l10n.removePlayerTooltip,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: colorScheme.surface,
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (context.read<GameCubit>().state.players.length >= 2) {
                        context.read<GameCubit>().startGame();
                      } else {
                        showErrorSnackBar(context, l10n.minimumOfTwoPlayers);
                      }
                    },
                    icon: const Icon(Icons.start_rounded),
                    label: Text(l10n.startGameButton),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
