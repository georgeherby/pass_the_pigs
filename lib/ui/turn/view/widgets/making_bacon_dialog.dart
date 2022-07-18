import 'package:flutter/material.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';
import 'package:pass_the_pigs/ui/common/destructive_dialog.dart';

class MakingBaconDialog extends StatelessWidget {
  const MakingBaconDialog({super.key, required this.onMakingBacon});
  final VoidCallback onMakingBacon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return DestructiveDialog(
      title: l10n.makingBacon,
      content: l10n.makingBaconDialogBody,
      onCancel: () {
        Navigator.of(context).pop();
      },
      onConfirm: () {
        onMakingBacon();
        Navigator.of(context).pop();
      },
    );
  }
}
