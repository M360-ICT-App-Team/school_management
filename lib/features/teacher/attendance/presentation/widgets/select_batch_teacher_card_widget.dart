import 'package:flutter/material.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../data/model/attendance_model.dart';
import '../../data/model/batch_over_view_teacher_response_model.dart';

class SelectBatchTeacherCardWidget extends StatefulWidget {
  final BatchOverViewTeacherResponseModel batchOverViewTeacherResponseModel;
  final int branchId;
  const SelectBatchTeacherCardWidget({
    super.key,
    required this.batchOverViewTeacherResponseModel,
    required this.branchId,
  });

  @override
  State<SelectBatchTeacherCardWidget> createState() =>
      _SelectBatchTeacherCardWidgetState();
}

class _SelectBatchTeacherCardWidgetState
    extends State<SelectBatchTeacherCardWidget> {
  @override
  Widget build(BuildContext context) {
    final batchOverView = widget.batchOverViewTeacherResponseModel;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.attendanceTeacherPage,
          arguments: AttendanceModel(
            batchId: batchOverView.id!,
            subjectId: batchOverView.subjectOfferingId!,
            branchId: widget.branchId,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.insidePadding / 2,
          vertical: AppSizes.insidePadding,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.bodyPadding,
          vertical: AppSizes.bodyPadding / 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.cardRadius),
          boxShadow: [AppColors.appShadow],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.insidePadding / 2),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withAlpha(60),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(AppIcons.subject),
                    ),
                    const SizedBox(width: AppSizes.bodyPadding),
                    Text(
                      batchOverView.subject ?? "",
                      style: AppTextStyles.normalBold(
                        context,
                      ).copyWith(fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withAlpha(40),
                    borderRadius: BorderRadius.circular(AppSizes.cardRadius),
                  ),
                  child: Row(
                    children: [
                      Icon(AppIcons.pending, color: AppColors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${batchOverView.attendancePending} চলমান",
                        style: AppTextStyles.normalBold(
                          context,
                        ).copyWith(color: AppColors.orange, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.insidePadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "শিক্ষার্থীর সংখ্যা: ${batchOverView.students}",
                  style: AppTextStyles.normalBold(
                    context,
                  ).copyWith(fontSize: 14),
                ),
                Text(
                  "ব্যাচ: ${batchOverView.batch}",
                  style: AppTextStyles.normalBold(
                    context,
                  ).copyWith(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "সেমিস্টার: ${batchOverView.semester}",
                  style: AppTextStyles.normalBold(
                    context,
                  ).copyWith(fontSize: 14),
                ),
                Icon(AppIcons.arrow, color: AppColors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
