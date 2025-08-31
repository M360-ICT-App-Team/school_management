import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/app_bottom_list_sheet.dart';

Future<T?> filteringBottomSheet<T>({
  required BuildContext context,
  required Bloc bloc,
  required dynamic event,
  required List<T>? Function(dynamic state) extractItems,
  required String Function(T item) getTitle,
  String emptyText = "কোনো তথ্য পাওয়া যায়নি",
}) async {
  bloc.add(event);

  return await showSelectionBottomSheet<T>(
    context: context,
    builder: (ctx, onSelect) {
      return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          final items = extractItems(state);
          if (items == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (items.isEmpty) {
            return Center(child: Text(emptyText));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(getTitle(item)),
                onTap: () => onSelect(item),
              );
            },
          );
        },
      );
    },
  );
}
