import 'package:flutter/material.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class TurnScoreCard extends StatelessWidget {
  const TurnScoreCard(this.currentThrow, this.turnScore, {super.key});
  final Throw currentThrow;
  final int turnScore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Card(
      color: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      l10n.turnScoreLabel,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '$turnScore',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 38,
                      child: Center(
                        child: (currentThrow.pigOne?.assetPath != null)
                            ? Image.asset(currentThrow.pigOne!.assetPath)
                            : const Text('-'),
                      ),
                    ),
                    Text(l10n.pigOneLabel,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                Column(
                  children: [
                    // Text(
                    //   l10n.rollScoreLabel,
                    //   style: Theme.of(context).textTheme.titleSmall,
                    // ),
                    Text(
                      '${currentThrow.getScore() ?? ''}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 32,
                      width: 38,
                      child: Center(
                        child: (currentThrow.pigTwo?.assetPath != null)
                            ? Image.asset(currentThrow.pigTwo!.assetPath)
                            : const Text('-'),
                      ),
                    ),
                    Text(
                      l10n.pigTwoLabel,
                      style: Theme.of(context).textTheme.titleMedium,
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
