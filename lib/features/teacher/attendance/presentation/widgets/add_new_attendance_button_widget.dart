import 'package:flutter/material.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';

class AddNewAttendanceButtonWidget extends StatefulWidget {
  const AddNewAttendanceButtonWidget({super.key});

  @override
  State<AddNewAttendanceButtonWidget> createState() => _AddNewAttendanceButtonWidgetState();
}

class _AddNewAttendanceButtonWidgetState extends State<AddNewAttendanceButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return     Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSizes.bodyPadding / 2,
                  vertical: AppSizes.bodyPadding / 2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.insidePadding * 5,
                  vertical: AppSizes.insidePadding,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.blue, width: 2),
                ),
                child: SizedBox(
                  width: 160,
                  height: 40,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.blue,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.newAttendanceCreatePage,
                      );
                    },
                    child: Text(
                      "নতুন যোগ করুন",
                      style: AppTextStyles.normalLight(
                        context,
                      ).copyWith(color: AppColors.white, fontSize: 16),
                    ),
                  ),
                ),
              );
  }
}