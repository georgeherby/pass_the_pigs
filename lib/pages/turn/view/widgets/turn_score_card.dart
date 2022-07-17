import 'package:flutter/material.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class TurnScoreCard extends StatelessWidget {
  const TurnScoreCard(this.turn, {super.key});
  final Throw turn;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      l10n.turnScoreLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                    ),
                    Text(
                      '${turn.getScore()}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 38,
                      child: Center(
                        child: (turn.pigOne?.assetPath != null)
                            ? Image.asset(turn.pigOne!.assetPath)
                            : const Text('-'),
                      ),
                    ),
                    Text(
                      l10n.pigOneLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 38,
                      child: Center(
                        child: (turn.pigTwo?.assetPath != null)
                            ? Image.asset(turn.pigTwo!.assetPath)
                            : const Text('-'),
                      ),
                    ),
                    Text(
                      l10n.pigTwoLabel,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
