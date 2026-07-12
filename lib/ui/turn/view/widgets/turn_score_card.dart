import 'package:flutter/material.dart';
import 'package:pass_the_pigs/common/common.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/theme/color_schemes.g.dart';

class TurnScoreCard extends StatelessWidget {
  const TurnScoreCard(this.currentThrow, this.turnScore, {super.key});

  final Throw currentThrow;
  final int turnScore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final rollScore = currentThrow.getScore();

    return Material(
      color: colorScheme.surfaceContainerHigh,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      borderRadius: BorderRadius.circular(appRadius),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(l10n.turnScoreLabel, style: textTheme.titleSmall),
            Text('$turnScore', style: textTheme.headlineMedium),
            Divider(
              height: 24,
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PigSlot(
                  label: l10n.pigOneLabel,
                  assetPath: currentThrow.pigOne?.assetPath,
                ),
                Column(
                  children: [
                    Text(l10n.rollScoreLabel, style: textTheme.titleSmall),
                    Text(
                      rollScore?.toString() ?? '–',
                      style: textTheme.headlineMedium,
                    ),
                  ],
                ),
                _PigSlot(
                  label: l10n.pigTwoLabel,
                  assetPath: currentThrow.pigTwo?.assetPath,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PigSlot extends StatelessWidget {
  const _PigSlot({required this.label, this.assetPath});

  final String label;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 32,
          width: 38,
          child: Center(
            child: assetPath != null
                ? Image.asset(assetPath!)
                : Text(
                    '–',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
          ),
        ),
        Text(label, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
