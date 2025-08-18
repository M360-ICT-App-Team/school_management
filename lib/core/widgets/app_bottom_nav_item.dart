
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppBottomNavItem extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const AppBottomNavItem({
    super.key,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 3,
          width: isSelected ? 30 : 0,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        IconButton(
          onPressed: onTap,
          icon: HugeIcon(
            icon: iconData,
            color: isSelected ? AppColors.primary : AppColors.lightGrey,
            size: isSelected ? AppSizes.iconBig : AppSizes.iconMedium,
          ),
        ),
      ],
    );
  }
}