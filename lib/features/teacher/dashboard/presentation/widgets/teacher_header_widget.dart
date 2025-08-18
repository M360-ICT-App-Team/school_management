import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';

class TeacherHeaderWidget extends StatefulWidget {
  const TeacherHeaderWidget({super.key});

  @override
  State<TeacherHeaderWidget> createState() => _TeacherHeaderWidgetState();
}

class _TeacherHeaderWidgetState extends State<TeacherHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.insidePadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "রিফাত হাসান প্রিয়",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
          ),
          Text(
            "আইডি: ",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
          ),
          Text(
            "দায়িত্বপ্রাপ্ত বিভাগ: সিভিল ইঞ্জিনিয়ারিং",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          Text(
            "০১৭১১১১১১১১",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "shorifful@gmail.com",
                style: AppTextStyles.normalLight(
                  context,
                ).copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),

              Icon(HugeIcons.strokeRoundedPencilEdit02),
            ],
          ),
        ],
      ),
    );
  }
}
