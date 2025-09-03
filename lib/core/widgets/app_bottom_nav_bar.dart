import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_images.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 6,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(AppImages.homeIcon, 0),
          _navItem(AppImages.notificationButton, 1),
          _navItem(AppImages.setting, 2),
        ],
      ),
    );
  }

  Widget _navItem(String icon, int index) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            color: isSelected ? Colors.white : Colors.white54,
            height: 30,
            width: 30,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
