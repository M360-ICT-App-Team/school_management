import 'package:flutter/material.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool showBack;

  const CustomAppBar({super.key, this.height = 70, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      centerTitle: true,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.logo, height: 30, width: 30),
          const SizedBox(width: 4),
          const Text(
            "BPI",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        // Add invisible widget with same width as leading to balance
        if (showBack) const SizedBox(width: kToolbarHeight),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
