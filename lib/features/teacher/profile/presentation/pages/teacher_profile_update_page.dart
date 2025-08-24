import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../../core/widgets/app_snackbar.dart';
import '../../data/model/teacher_profile_response_model.dart';
import '../../data/model/teacher_profile_update_request_model.dart';
import '../bloc/teacher_profile_bloc.dart';

class TeacherProfileUpdatePage extends StatefulWidget {
  const TeacherProfileUpdatePage({super.key});

  @override
  State<TeacherProfileUpdatePage> createState() =>
      _TeacherProfileUpdatePageState();
}

class _TeacherProfileUpdatePageState extends State<TeacherProfileUpdatePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    presentAddressController.dispose();
    permanentAddressController.dispose();
    bloodGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),

        body: BlocConsumer<TeacherProfileBloc, TeacherProfileState>(
          listener: (context, state) {
            if (state is TeacherProfileUpdateLoading) {
              AppBottomSheets.showLoading(context, message: "Loading...");
            } else if (state is TeacherProfileUpdateSuccess) {
              AppBottomSheets.hide(context);
              context.read<TeacherProfileBloc>().add(GetTeacherProfileEvent());
              Navigator.pop(context);

              AppBottomSheets.showSuccess(
                context,
                message: "Profile updated successfully",
              );
            } else if (state is TeacherProfileUpdateError) {
              AppBottomSheets.hide(context);
              context.read<TeacherProfileBloc>().add(GetTeacherProfileEvent());
              AppBottomSheets.showError(context, message: state.message);
            }
          },
          builder: (context, state) {
            TeacherProfileResponseModel? teacherProfile;

            if (state is TeacherProfileSuccess) {
              teacherProfile = state.teacherProfileResponseModel;
              phoneController.text = teacherProfile.phone.toString();
              emailController.text = teacherProfile.email.toString();
              fatherNameController.text = teacherProfile.fatherName.toString();
              motherNameController.text = teacherProfile.motherName.toString();
              presentAddressController.text = teacherProfile.presentAddress
                  .toString();
              permanentAddressController.text = teacherProfile.permanentAddress
                  .toString();
              bloodGroupController.text = teacherProfile.bloodGroup.toString();
            }

            return ListView(
              children: [
                Column(
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
                              Image.asset(
                                AppImages.logo,
                                height: 120,
                                width: 120,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    AppSizes.insidePadding / 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            phoneController,
                          ),
                          profileInfoList(context, "ইমেইল", emailController),
                          profileInfoList(
                            context,
                            "পিতার নাম",
                            fatherNameController,
                          ),
                          profileInfoList(
                            context,
                            "মাতার নাম",
                            motherNameController,
                          ),
                          profileInfoList(
                            context,
                            "বর্তমান ঠিকানা",
                            presentAddressController,
                            isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "স্থায়ী ঠিকানা",
                            permanentAddressController,
                            isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "রক্তের গ্রুপ",
                            bloodGroupController,
                          ),
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
                        onPressed: () {
                          final teacherProfileUpdateRequestModel =
                              TeacherProfileUpdateRequestModel(
                                email:
                                    emailController.text.trim() ==
                                        (teacherProfile?.email ?? "").trim()
                                    ? null
                                    : emailController.text.trim(),
                                phone:
                                    phoneController.text.trim() ==
                                        (teacherProfile?.phone ?? "").trim()
                                    ? null
                                    : phoneController.text.trim(),
                                fatherName: fatherNameController.text,
                                motherName: motherNameController.text,
                                presentAddress: presentAddressController.text,
                                permanentAddress:
                                    permanentAddressController.text,
                                bloodGroup: bloodGroupController.text,
                              );
                          context.read<TeacherProfileBloc>().add(
                            UpdateTeacherProfileEvent(
                              payload: teacherProfileUpdateRequestModel,
                              files: [],
                            ),
                          );
                        },
                        child: Text("নিশ্চিত করুন"),
                      ),
                    ),
                  ],
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
    TextEditingController controller, {
    bool? isMultiLine = false,
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
            child: TextField(
              controller: controller,
              maxLines: isMultiLine! ? 3 : 1,
              style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
