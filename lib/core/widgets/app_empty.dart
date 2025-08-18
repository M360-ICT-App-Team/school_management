
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

class AppEmpty extends StatelessWidget {
  const AppEmpty({super.key, required this.msg, this.icon});

  final String? msg;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.bodyPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(),
            Container(
                padding: const EdgeInsets.all(AppSizes.bodyPadding),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightGrey.withValues(alpha: 0.1)),
                child: HugeIcon(
                  icon: icon ?? HugeIcons.strokeRoundedInformationCircle,
                  color: AppColors.red,
                  size: 40,
                )),
            const SizedBox(
              height: AppSizes.insidePadding,
            ),
            Text(
              msg ?? 'Something went wrong',
              // maxLines: 2,
              // overflow: TextOverflow.ellipsis,
              style: AppTextStyles.normalLight(context).copyWith(color: AppColors.red),
              textAlign: TextAlign.center,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
