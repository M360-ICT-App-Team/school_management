import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> appAdaptiveDialog({
  required BuildContext context,
   String ? title,
  required String message,
  List<AdaptiveDialogAction>? actions,
}) {
  final defaultActions = [
    AdaptiveDialogAction(
      text: 'Dismiss',
      onPressed: () => Navigator.of(context).pop(),
      isDestructive: false,
    ),
  ];

  final combinedActions = actions ?? defaultActions;

  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title ?? 'Oops!'),
        content: Text(message),
        actions: combinedActions.map((action) {
          return CupertinoDialogAction(
            onPressed: action.onPressed,
            isDestructiveAction: action.isDestructive,
            isDefaultAction: action.isDefault,
            child: Text(action.text),
          );
        }).toList(),
      ),
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Oops!'),
        content: Text(message),
        actions: combinedActions.map((action) {
          return TextButton(
            onPressed: action.onPressed,
            style: TextButton.styleFrom(
              foregroundColor: action.isDestructive
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.primary,
            ),
            child: Text(action.text),
          );
        }).toList(),
      ),
    );
  }
}

class AdaptiveDialogAction {
  final String text;
  final VoidCallback onPressed;
  final bool isDestructive;
  final bool isDefault;

  AdaptiveDialogAction({
    required this.text,
    required this.onPressed,
    this.isDestructive = false,
    this.isDefault = false,
  });
}
