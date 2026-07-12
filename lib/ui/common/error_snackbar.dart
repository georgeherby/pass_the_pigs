import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  final colorScheme = Theme.of(context).colorScheme;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: colorScheme.errorContainer,
      content: Text(
        message,
        style: TextStyle(color: colorScheme.onErrorContainer),
      ),
    ),
  );
}
