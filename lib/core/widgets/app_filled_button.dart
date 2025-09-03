import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppFilledButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  final Color? backgroundColor;

  const AppFilledButton({
    super.key,
    required this.title,
    required this.onPressed,

    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.insidePadding,
          vertical: AppSizes.insidePadding,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
