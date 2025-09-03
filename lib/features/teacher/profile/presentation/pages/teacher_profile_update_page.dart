import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/core/constants/app_urls.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../../core/widgets/app_bottom_list.dart';
import '../../../../../core/widgets/app_image_view.dart';
import '../../../../../core/widgets/app_input_widgets.dart';
import '../../../../../core/widgets/app_snackbar.dart';
import '../../../../../core/widgets/pick_image.dart';
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
  // TextEditingController bloodGroupController = TextEditingController();
  ValueNotifier<String> gender = ValueNotifier('লিঙ্গ নির্বাচন করুন');
  ValueNotifier<String> bloodGroup = ValueNotifier(
    'রক্তের গ্রুপ নির্বাচন করুন',
  );
  final List<String> genderList = ["পুরুষ", "মহিলা", "অন্যান্য"];
  final List<String> bloodGroupList = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  XFile? photo;
  String networkImage = '';

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    presentAddressController.dispose();
    permanentAddressController.dispose();
    // bloodGroupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            phoneController.text = teacherProfile.phone ?? "";
            emailController.text = teacherProfile.email ?? "";
            fatherNameController.text = teacherProfile.fatherName ?? "";
            motherNameController.text = teacherProfile.motherName ?? "";
            presentAddressController.text = teacherProfile.presentAddress ?? "";
            permanentAddressController.text =
                teacherProfile.permanentAddress ?? "";
            gender.value = teacherProfile.gender ?? 'লিঙ্গ নির্বাচন করুন';

            bloodGroup.value = teacherProfile.bloodGroup ?? "";
            final serverPhoto = teacherProfile.photo;
            networkImage =
                (serverPhoto == null ||
                    serverPhoto.isEmpty ||
                    serverPhoto.contains("https://shorturl.at"))
                ? 'https://shorturl.at/RfnsS'
                : serverPhoto;
            debugPrint("======== photo url ======  ${AppUrls.imageUrl}");
            log("======== photo ======  $serverPhoto");
          }

          return ListView(
            children: [
              Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
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
                          //!for basic information
                          Row(
                            children: [
                              Center(
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    photo != null
                                        ? Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Image.file(
                                              File(photo!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : AppCachedNetworkImage(
                                            url: networkImage,
                                            height: 100,
                                            width: 100,
                                            isPerson: true,
                                          ),
                                    Card(
                                      child: IconButton(
                                        onPressed: () async {
                                          photo = await appPickImage(context);
                                          if (photo != null) {
                                            setState(() {});
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_rounded,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                          //!end for basic information

                          //!for update information
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'লিঙ্গ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final selected =
                                        await showSelectionBottomSheetList<
                                          String
                                        >(
                                          context: context,
                                          items: genderList,
                                          itemLabel: (item) => item,
                                        );
                                    if (selected != null) {
                                      gender.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.insidePadding * 3,
                                      vertical: 10,
                                    ),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: AppSizes.insidePadding,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: gender,
                                          builder: (context, value, child) {
                                            return Text(
                                              value,
                                              style: AppTextStyles.normalLight(
                                                context,
                                              ).copyWith(fontSize: 14),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                          // profileInfoList(
                          //   context,
                          //   "রক্তের গ্রুপ",
                          //   bloodGroupController,
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'রক্তের গ্রুপ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final selected =
                                        await showSelectionBottomSheetList<
                                          String
                                        >(
                                          context: context,
                                          items: bloodGroupList,
                                          itemLabel: (item) => item,
                                        );
                                    if (selected != null) {
                                      bloodGroup.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.insidePadding * 3,
                                      vertical: 10,
                                    ),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          width: AppSizes.insidePadding,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: bloodGroup,
                                          builder: (context, value, child) {
                                            return Text(
                                              value,
                                              style: AppTextStyles.normalLight(
                                                context,
                                              ).copyWith(fontSize: 14),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //!end for update information
                        ],
                      ),
                    ),
                  ),

                  //!for call profile update event button
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
                              permanentAddress: permanentAddressController.text,
                              gender: gender.value,
                              bloodGroup: bloodGroup.value,
                            );
                        context.read<TeacherProfileBloc>().add(
                          UpdateTeacherProfileEvent(
                            payload: teacherProfileUpdateRequestModel,
                            files: photo != null
                                ? [
                                    SendFileModel(
                                      filePath: photo!.path,
                                      key: "photo",
                                    ),
                                  ]
                                : [],
                          ),
                        );
                      },
                      child: Text("নিশ্চিত করুন"),
                    ),
                  ),
                  //!end for call profile update event button
                ],
              ),
            ],
          );
        },
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
            child: AppTextField(
              controller: controller,
              maxLine: isMultiLine! ? 3 : 1,
              fillColor: false,
            ),
          ),
        ],
      ),
    );
  }
}
