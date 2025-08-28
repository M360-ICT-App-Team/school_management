import 'package:flutter/material.dart';

Future<T?> showSelectionBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext, void Function(T)) builder,
  double heightFactor = 0.5,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (ctx) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * heightFactor,
        child: builder(ctx, (value) {
          Navigator.pop(ctx, value); // এখানে value return হবে
        }),
      );
    },
  );
}

