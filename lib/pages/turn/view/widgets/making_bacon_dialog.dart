import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:pass_the_pigs/l10n/l10n.dart';

class MakingBaconDialog extends StatelessWidget {
  const MakingBaconDialog({super.key, required this.onMakingBacon});
  final VoidCallback onMakingBacon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return PlatformAlertDialog(
      title: Text(l10n.makingBacon),
      content: Text(l10n.makingBaconDialogBody),
      actions: <Widget>[
        PlatformDialogAction(
          child: Text(l10n.cancel),
          cupertino: (context, _) => CupertinoDialogActionData(
            isDefaultAction: false,
            isDestructiveAction: false,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        PlatformDialogAction(
          child: Text(l10n.resetScore),
          material: (context, platform) => MaterialDialogActionData(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error),
          ),
          cupertino: (context, _) => CupertinoDialogActionData(
              isDefaultAction: true, isDestructiveAction: true),
          onPressed: () {
            onMakingBacon();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
