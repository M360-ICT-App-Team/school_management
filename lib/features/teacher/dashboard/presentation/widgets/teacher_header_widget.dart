import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../profile/data/model/teacher_profile_response_model.dart';

class TeacherHeaderWidget extends StatefulWidget {
  final TeacherProfileResponseModel? teacherProfile;
  const TeacherHeaderWidget({super.key, required this.teacherProfile});

  @override
  State<TeacherHeaderWidget> createState() => _TeacherHeaderWidgetState();
}

class _TeacherHeaderWidgetState extends State<TeacherHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final profile = widget.teacherProfile;
    return Padding(
      padding: const EdgeInsets.all(AppSizes.insidePadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile?.name ?? "Unknown",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
          ),
          Text(
            "আইডি: ${profile?.id ?? "Unknown"} ",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
          ),
          Text(
            "দায়িত্বপ্রাপ্ত বিভাগ: ${profile?.departmentName ?? "Unknown"}",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          Text(
            profile?.phone ?? "Unknown",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                
                child: Text(
                  profile?.email ?? "Unknown",
                  style: AppTextStyles.normalLight(
                    context,
                  ).copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, 
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.teacherProfileUpdatePage,
                  );
                },
                child: const Icon(HugeIcons.strokeRoundedPencilEdit02),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
