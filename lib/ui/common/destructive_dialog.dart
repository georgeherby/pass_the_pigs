import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class DestructiveDialog extends StatelessWidget {
  const DestructiveDialog(
      {super.key,
      required this.onConfirm,
      required this.onCancel,
      required this.title,
      required this.content});
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: Text(l10n.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        ),
        TextButton(
            onPressed: onConfirm,
            child: Text(l10n.resetScore,
                style: TextStyle(color: Theme.of(context).colorScheme.error))),
      ],
    );
  }
}
