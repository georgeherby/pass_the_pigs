import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';

class OinkerDialog extends StatelessWidget {
  const OinkerDialog({super.key, required this.onOinker});
  final VoidCallback onOinker;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DestructiveDialog(
      destroyButtonText: l10n.resetScore,
      title: l10n.oinker,
      content: l10n.oinkerDialogBody,
      onCancel: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        onOinker();
        Navigator.of(context).pop();
      },
    );
  }
}
