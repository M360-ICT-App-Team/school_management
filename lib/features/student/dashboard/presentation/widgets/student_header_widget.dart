import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../profile/data/model/student_profile_response_model.dart';
import '../../../profile/presentation/page/student_profile_update.dart';

class StudentHeaderWidget extends StatefulWidget {
  final StudentProfileResponseModel? studentProfile;
  const StudentHeaderWidget({super.key, required this.studentProfile});

  @override
  State<StudentHeaderWidget> createState() => _StudentHeaderWidgetState();
}

class _StudentHeaderWidgetState extends State<StudentHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    final profile = widget.studentProfile;
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
            //"দায়িত্বপ্রাপ্ত বিভাগ: ${profile?.departmentName ?? "Unknown"}",
            "বিভাগ: ${profile?.departmentName ?? "Unknown"}",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),

          /*Text(
            profile?.phone ?? "Unknown",
            style: AppTextStyles.normalLight(context).copyWith(fontSize: 12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             /* Expanded(
                child: Text(
                  profile?.email ?? "Unknown",
                  style: AppTextStyles.normalLight(
                    context,
                  ).copyWith(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),*/
              InkWell(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(
                      CupertinoPageRoute(builder: (_) => StudentProfileUpdatePage(
                      )));
               //!for update student profile
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
