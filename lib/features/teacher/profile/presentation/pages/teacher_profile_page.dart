import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/widgets/app_bar.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../data/model/teacher_profile_response_model.dart';
import '../bloc/teacher_profile_bloc.dart';

class TeacherProfilePage extends StatefulWidget {
  const TeacherProfilePage({super.key});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),

        body: BlocBuilder<TeacherProfileBloc, TeacherProfileState>(
          builder: (context, state) {
            TeacherProfileResponseModel? teacherProfile;
            if (state is TeacherProfileSuccess) {
              teacherProfile = state.teacherProfileResponseModel;
            }
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSizes.insidePadding,
                    vertical: AppSizes.insidePadding,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.insidePadding,
                    vertical: AppSizes.insidePadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.blue, width: 2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(AppImages.logo, height: 120, width: 120),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(
                                AppSizes.insidePadding / 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    teacherProfile?.name ?? "Unknown",
                                    style: AppTextStyles.normalLight(
                                      context,
                                    ).copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    "আইডি: ${teacherProfile?.id ?? "Unknown"} ",
                                    style: AppTextStyles.normalLight(
                                      context,
                                    ).copyWith(fontSize: 12),
                                  ),
                                  Text(
                                    "দায়িত্বপ্রাপ্ত বিভাগ: ${teacherProfile?.departmentName ?? "Unknown"}",
                                    style: AppTextStyles.normalLight(
                                      context,
                                    ).copyWith(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),

                                  Text(
                                    teacherProfile?.phone ?? "Unknown",
                                    style: AppTextStyles.normalLight(
                                      context,
                                    ).copyWith(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        teacherProfile?.email ?? "Unknown",
                                        style: AppTextStyles.normalLight(
                                          context,
                                        ).copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.insidePadding),
                      profileInfoList(
                        context,
                        "ফোন নম্বর",
                        teacherProfile?.phone ?? "Unknown",
                        isEditIcon: true,
                      ),
                      profileInfoList(
                        context,
                        "ইমেইল",
                        teacherProfile?.email ?? "Unknown",
                      ),
                      profileInfoList(
                        context,
                        "পিতার নাম",
                        teacherProfile?.name ?? "Unknown",
                      ),
                      profileInfoList(context, "মাতার নাম", "রোকেয়া বেগম"),
                      profileInfoList(context, "বর্তমান ঠিকানা", ""),
                      profileInfoList(context, "স্থায়ী ঠিকানা", ""),
                      profileInfoList(context, "রক্তের গ্রুপ", "O+"),
                    ],
                  ),
                ),
                SizedBox(
                  width: 190,
                  height: 40,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.blue,
                    ),
                    onPressed: () {},
                    child: Text("তথ্য পরিবর্তন করুন"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget profileInfoList(
    BuildContext context,
    String key,
    String value, {
    bool? isEditIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.insidePadding / 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              key,
              style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
            ),
          ),
          const Text(" : "),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          if (isEditIcon ?? false)
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.teacherProfileUpdatePage,
                );
              },
              child: Icon(HugeIcons.strokeRoundedPencilEdit02),
            ),
        ],
      ),
    );
  }
}
