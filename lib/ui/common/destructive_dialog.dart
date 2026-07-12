import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class DestructiveDialog extends StatelessWidget {
  const DestructiveDialog({
    super.key,
    required this.onConfirm,
    required this.destroyButtonText,
    required this.onCancel,
    required this.title,
    required this.content,
  });

  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final String title;
  final String content;
  final String destroyButtonText;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: Text(l10n.cancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          ),
          onPressed: onConfirm,
          child: Text(destroyButtonText),
        ),
      ],
    );
  }
}
