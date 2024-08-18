import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';

class OffTheTableDialog extends StatelessWidget {
  const OffTheTableDialog({super.key, required this.onOffTheTable});
  final VoidCallback onOffTheTable;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DestructiveDialog(
      destroyButtonText: l10n.resetScore,
      title: l10n.offTheTable,
      content: l10n.offTheTableDialogBody,
      onCancel: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        onOffTheTable();
        Navigator.of(context).pop();
      },
    );
  }
}
