import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../../core/widgets/app_bottom_list.dart';
import '../../../../../core/widgets/app_image_view.dart';
import '../../../../../core/widgets/app_input_widgets.dart';
import '../../../../../core/widgets/app_snackbar.dart';
import '../../../../../core/widgets/pick_image.dart';
import '../../data/model/student_profile_response_model.dart';
import '../../data/model/student_profile_update_request_model.dart';
import '../bloc/student_profile_bloc.dart';

class StudentProfileUpdatePage extends StatefulWidget {
  const StudentProfileUpdatePage({super.key});

  @override
  State<StudentProfileUpdatePage> createState() =>
      _StudentProfileUpdatePageState();
}

class _StudentProfileUpdatePageState extends State<StudentProfileUpdatePage> {
  TextEditingController birthRegNo = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController presentZipCodeController = TextEditingController();
  TextEditingController thanaController = TextEditingController();
  TextEditingController presentThanaController = TextEditingController();
  TextEditingController presentAddressController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherNidController = TextEditingController();
  TextEditingController fatherPhoneController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherNidController = TextEditingController();
  TextEditingController motherPhoneController = TextEditingController();
  TextEditingController localGuardianController = TextEditingController();
  TextEditingController localGuardianRelationController = TextEditingController();
  TextEditingController localGuardianNidController = TextEditingController();
  TextEditingController localGuardianPhoneController = TextEditingController();
  TextEditingController localGuardianEmaPhoneController =
      TextEditingController();

  XFile? photo;
  String networkImage = '';
  StudentProfileResponseModel? studentProfile;
  ValueNotifier<String> religion = ValueNotifier('ধর্ম নির্বাচন করুন');
  ValueNotifier<String> gender = ValueNotifier('লিঙ্গ নির্বাচন করুন');
  ValueNotifier<String> permanentAddressDivision = ValueNotifier('বিভাগ নির্বাচন করুন');
  ValueNotifier<String> presentAddressDivision = ValueNotifier('বিভাগ নির্বাচন করুন');
  ValueNotifier<String> bloodGroup = ValueNotifier('রক্তের গ্রুপ নির্বাচন করুন');
  ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(),

      body: BlocConsumer<StudentProfileBloc, StudentProfileState>(
        listener: (context, state) {
          if (state is StudentProfileUpdateLoading) {
            AppBottomSheets.showLoading(context, message: "Loading...");
          } else if (state is StudentProfileUpdateSuccess) {
            AppBottomSheets.hide(context);
            context.read<StudentProfileBloc>().add(GetStudentProfileEvent());
            Navigator.pop(context);

            AppBottomSheets.showSuccess(
              context,
              message: "Profile updated successfully",
            );
          } else if (state is StudentProfileUpdateError) {
            AppBottomSheets.hide(context);
            context.read<StudentProfileBloc>().add(GetStudentProfileEvent());
            AppBottomSheets.showError(context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is StudentProfileSuccess) {
            studentProfile = state.studentProfileResponseModel;
            birthRegNo.text = studentProfile?.dobNo ?? '';
            bloodGroup.value = studentProfile?.bloodGroup ?? '';
            permanentAddressController.text =
                studentProfile?.permanentAddress ?? '';
            zipCodeController.text = studentProfile?.permanentPostalCode ?? '';
            presentZipCodeController.text =
                studentProfile?.presentPostalCode ?? '';
            thanaController.text = studentProfile?.permanentThana ?? '';
            presentAddressController.text =
                studentProfile?.presentAddress ?? '';
            presentThanaController.text = studentProfile?.presentThana ?? '';
            fatherNameController.text = studentProfile?.fatherName ?? '';
            fatherNidController.text = studentProfile?.fatherNidNo ?? '';
            fatherPhoneController.text = studentProfile?.fatherPhone ?? '';
            motherNameController.text = studentProfile?.motherName ?? '';
            motherNidController.text = studentProfile?.motherNidNo ?? '';
            motherPhoneController.text = studentProfile?.motherPhone ?? '';
            localGuardianController.text =
                studentProfile?.localGuardianName ?? '';
            localGuardianNidController.text =
                studentProfile?.localGuardianNidNo ?? '';
            localGuardianPhoneController.text =
                studentProfile?.localGuardianPhone ?? '';
            localGuardianRelationController.text = studentProfile?.localGuardianRelation ?? '';

            // dropdowns
            gender.value = studentProfile?.gender ?? 'লিঙ্গ নির্বাচন করুন';
            religion.value = studentProfile?.religion ?? 'ধর্ম নির্বাচন করুন';
            permanentAddressDivision.value = studentProfile?.permanentDivision ?? 'বিভাগ নির্বাচন করুন';
            presentAddressDivision.value = studentProfile?.presentDivision ?? 'বিভাগ নির্বাচন করুন';

            //selectedDate.value = studentProfile?.dobDate??DateTime.now();
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
                        spacing: 5,
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
                                            url: studentProfile?.photo ?? '',
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
                                        studentProfile?.name ?? "Unknown",
                                        style: AppTextStyles.normalLight(
                                          context,
                                        ).copyWith(fontSize: 12),
                                      ),
                                      Text(
                                        "আইডি: ${studentProfile?.id ?? "Unknown"} ",
                                        style: AppTextStyles.normalLight(
                                          context,
                                        ).copyWith(fontSize: 12),
                                      ),
                                      Text(
                                        "বিভাগ: ${studentProfile?.departmentName ?? "Unknown"}",
                                        style: AppTextStyles.normalLight(
                                          context,
                                        ).copyWith(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //!for update information
                          SizedBox(height: AppSizes.insidePadding),
                          profileInfoList(context, "জন্ম নিবন্ধ নং", birthRegNo),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'জন্ম তারিখ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: ValueListenableBuilder(
                                  valueListenable:selectedDate,
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () async {
                                        await pickAdaptiveDate(
                                          context: context,
                                          notifier: selectedDate,
                                          initialDate: value,
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );
                                      },
                                      child: _buildBox(
                                        child: Text(
                                          "${formatDateTime(dateTime: value, format: "yyyy-MM-dd")}",
                                          style: AppTextStyles.normalLight(
                                            context,
                                          ).copyWith(fontSize: 14),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'ধর্ম',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final selected = await showSelectionBottomSheetList<String>(
                                        context: context,
                                        items: religionList,
                                        itemLabel: (item) => item
                                    );
                                    if (selected != null) {
                                      religion.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*3,vertical: 10),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: AppSizes.insidePadding),
                                        ValueListenableBuilder(
                                          valueListenable: religion,
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
                                    final selected = await showSelectionBottomSheetList<String>(
                                        context: context,
                                        items: genderList,
                                        itemLabel: (item) => item
                                    );
                                    if (selected != null) {
                                      gender.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*3,vertical: 10),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: AppSizes.insidePadding),
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
                                    final selected = await showSelectionBottomSheetList<String>(
                                        context: context,
                                        items: bloodGroupList,
                                        itemLabel: (item) => item
                                    );
                                    if (selected != null) {
                                      bloodGroup.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*3,vertical: 10),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: AppSizes.insidePadding),
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
                          profileInfoList(context, "স্থায়ী ঠিকানা", permanentAddressController, isMultiLine: true,),
                          profileInfoList(context, "পোস্ট কোড", zipCodeController,),
                          profileInfoList(context, "থানা", thanaController),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'বিভাগ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final selected = await showSelectionBottomSheetList<String>(
                                      context: context,
                                      items: divisionList,
                                      itemLabel: (item) => item
                                    );
                                    if (selected != null) {
                                      permanentAddressDivision.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*3,vertical: 10),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: AppSizes.insidePadding),
                                        ValueListenableBuilder(
                                          valueListenable: permanentAddressDivision,
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
                          profileInfoList(context, "বর্তমান ঠিকানা", presentAddressController, isMultiLine: true,),
                          profileInfoList(context, "পোস্ট কোড", presentZipCodeController,),

                          profileInfoList(context, "থানা", presentThanaController),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'বিভাগ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              Expanded(
                                child: InkWell(
                                  onTap: () async {
                                    final selected = await showSelectionBottomSheetList<String>(
                                        context: context,
                                        items: divisionList,
                                        itemLabel: (item) => item
                                    );
                                    if (selected != null) {
                                      presentAddressDivision.value = selected;
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*3,vertical: 10),
                                    //margin: const EdgeInsets.symmetric(horizontal: AppSizes.insidePadding*2,),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black, width: 1.5),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(width: AppSizes.insidePadding),
                                        ValueListenableBuilder(
                                          valueListenable: permanentAddressDivision,
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
                          profileInfoList(context, "পিতার নাম", fatherNameController),
                          profileInfoList(context, "জাতীয় পরিচয়পত্র নং", fatherNidController),
                          profileInfoList(context, "মোবাইল নম্বর", fatherPhoneController),
                          profileInfoList(context, "মাতার নাম", motherNameController),
                          profileInfoList(context, "জাতীয় পরিচয়পত্র নং", motherNidController),
                          profileInfoList(context, "মোবাইল নম্বর", motherPhoneController),
                          profileInfoList(context, "স্থানীয় গার্ডিয়ানের নাম", localGuardianController),
                          profileInfoList(context, "স্থানীয় গার্ডিয়ানের সম্পর্ক", localGuardianRelationController),
                          profileInfoList(context,"জাতীয় পরিচয়পত্র নং",localGuardianNidController),
                          profileInfoList(context, "মোবাইল নম্বর", localGuardianPhoneController)
                          //!end for update information
                        ],
                      ),
                    ),
                  ),
                  //!for call profile update event button
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: 190,
                      height: 40,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                        ),
                        onPressed: () {
                          final studentProfileUpdateRequestModel =
                              StudentProfileUpdateRequestModel(
                                dobNo: birthRegNo.text.trim(),
                                dobDate:  DateFormat("yyyy-MM-dd").format(selectedDate.value),
                                religion: religion.value,
                                gender: gender.value,
                                bloodGroup: bloodGroup.value,
                                permanentAddress: permanentAddressController.text
                                    .trim(),
                                permanentPostalCode: zipCodeController.text
                                    .trim(),
                                permanentThana: thanaController.text.trim(),
                                permanentDivision: permanentAddressDivision.value,
                                presentAddress: presentAddressController.text
                                    .trim(),
                                presentThana: presentThanaController.text.trim(),
                                presentPostelCode: presentZipCodeController.text
                                    .trim(),
                                fatherName: fatherNameController.text.trim(),
                                fatherNidNo: fatherNidController.text.trim(),
                                fatherPhone:
                                    fatherPhoneController.text.trim() ==
                                        (studentProfile?.fatherPhone ?? "").trim()
                                    ? null
                                    : fatherPhoneController.text.trim(),

                                motherName: motherNameController.text.trim(),
                                motherNidNo: motherNidController.text.trim(),
                                motherPhone:
                                    motherPhoneController.text.trim() ==
                                        (studentProfile?.motherPhone ?? "").trim()
                                    ? null
                                    : motherPhoneController.text.trim(),

                                localGuardianName: localGuardianController.text
                                    .trim(),
                                localGuardianNidNo: localGuardianNidController
                                    .text
                                    .trim(),
                                localGuardianRelation:
                                localGuardianRelationController.text,
                                localGuardianPhone:
                                    localGuardianPhoneController.text.trim() ==
                                        (studentProfile?.localGuardianPhone ?? "")
                                            .trim()
                                    ? null
                                    : localGuardianPhoneController.text.trim(),

                                presentDivision: presentAddressDivision.value,
                                name: studentProfile!.name,
                                is2FaOn: false,
                                emergencyPhoneNo:  (studentProfile?.localGuardianPhone ?? "")
                                    .trim()

                              );

                          context.read<StudentProfileBloc>().add(
                            UpdateStudentProfileEvent(
                              payload: studentProfileUpdateRequestModel,
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
//! Custom Text Field
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
            child: SizedBox(
              child: AppTextField(
                controller: controller,
                maxLine: isMultiLine! ? 3 : 1,
                fillColor: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        children: [
          child,
          const SizedBox(width: 4),
          const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
        ],
      ),
    );
  }
//! list Start
  final List<String> religionList = ["ইসলাম", "হিন্দু", "বৌদ্ধ", "খ্রিষ্টান", "অন্যান্য"];
  final List<String> genderList = ["পুরুষ", "মহিলা", "অন্যান্য"];
  final List<String> divisionList = ["ঢাকা", "চট্টগ্রাম", "রাজশাহী", "খুলনা", "বরিশাল", "সিলেট", "রংপুর", "ময়মনসিংহ"];
  final List<String> bloodGroupList = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

//!List end

}
