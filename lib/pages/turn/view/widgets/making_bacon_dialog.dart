import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class MakingBaconDialog extends StatelessWidget {
  const MakingBaconDialog({super.key, required this.onMakingBacon});
  final VoidCallback onMakingBacon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(l10n.makingBacon),
      content: Text(l10n.makingBaconDialogBody),
      actions: <Widget>[
        TextButton(
          child: Text(l10n.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(l10n.resetScore,
              style: TextStyle(color: Theme.of(context).colorScheme.error)),
          onPressed: () {
            onMakingBacon();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
