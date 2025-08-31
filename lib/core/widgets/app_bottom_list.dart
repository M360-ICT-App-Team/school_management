import 'package:flutter/material.dart';


Future<T?> showSelectionBottomSheetList<T>({
  required BuildContext context,
  required List<T> items,
  required String Function(T) itemLabel,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: (ctx) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(itemLabel(item)),
            onTap: () => Navigator.pop(ctx, item),
          );
        },
      );
    },
  );
}

