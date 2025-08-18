import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import 'dart:io' show Platform;

Future<T?> showAdaptiveBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? maxHeight,
  bool isScrollControlled = true,
}) {
  final theme = Theme.of(context);
  final isIOS = Platform.isIOS;

  Widget buildSheetContent(Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with drag handle and close button
        Padding(
          padding: EdgeInsets.only(top: AppSizes.insidePadding, bottom: AppSizes.bodyPadding),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Drag handle (centered)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Close button aligned to end
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.bodyPadding),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Close',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content
        Flexible(child: child),
      ],
    );
  }

  if (isIOS) {
    return showCupertinoModalPopup<T>(
      context: context,
      builder: (ctx) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Container(
            height: maxHeight ?? MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: theme.canvasColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppSizes.radiusLarge),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.bodyPadding,
            ),
            child: buildSheetContent(child),
          ),
        ),
      ),
    );
  } else {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          maxChildSize: 0.9,
          minChildSize: 0.25,
          builder: (_, controller) {
            return Container(
              padding: EdgeInsets.symmetric( horizontal: AppSizes.bodyPadding),
              decoration: BoxDecoration(
                color: theme.canvasColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppSizes.radiusLarge),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: buildSheetContent(
                SingleChildScrollView(
                  controller: controller,
                  child: child,
                ),
              ),
            );
          },
        );
      },
    );
  }
}