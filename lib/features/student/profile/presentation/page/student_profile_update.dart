import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:school_management/core/utilities/app_convert_date_time.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../../../../core/widgets/app_bar.dart';
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
  TextEditingController bloodGroupController = TextEditingController();
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
  TextEditingController localGuardianNidController = TextEditingController();
  TextEditingController localGuardianPhoneController = TextEditingController();
  TextEditingController localGuardianEmaPhoneController =
      TextEditingController();

  XFile? photo;
  String networkImage = '';
  StudentProfileResponseModel? studentProfile;
  ValueNotifier<String> religion = ValueNotifier('ধর্ম নির্বাচন করুন');
  ValueNotifier<String> gender = ValueNotifier('লিঙ্গ নির্বাচন করুন');
  ValueNotifier<String> permanentAddressDivision = ValueNotifier(
    'বিভাগ নির্বাচন করুন',
  );
  ValueNotifier<String> presentAddressDivision = ValueNotifier(
    'বিভাগ নির্বাচন করুন',
  );
  ValueNotifier<String?> selectedDate = ValueNotifier(null);

  @override
  void dispose() {
    birthRegNo.dispose();
    bloodGroupController.dispose();
    motherNameController.dispose();
    presentAddressController.dispose();
    permanentAddressController.dispose();
    bloodGroupController.dispose();
    zipCodeController.dispose();
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
            bloodGroupController.text = studentProfile?.bloodGroup ?? '';
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

            // dropdowns
            gender.value = studentProfile?.gender ?? 'লিঙ্গ নির্বাচন করুন';
            religion.value = studentProfile?.religion ?? 'ধর্ম নির্বাচন করুন';
            permanentAddressDivision.value =
                studentProfile?.permanentDivision ?? 'বিভাগ নির্বাচন করুন';
            presentAddressDivision.value =
                studentProfile?.presentDivision ?? 'বিভাগ নির্বাচন করুন';

            selectedDate.value = studentProfile?.dobDate;
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
                          profileInfoList(
                            context,
                            "জন্ম নিবন্ধ নং",
                            birthRegNo,
                          ),
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
                              GestureDetector(
                                onTap: () {
                                  _selectDate(context);
                                  
                                },
                                child: Container(
                                  width: 230,
                                  height:
                                      30, 
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: selectedDate,
                                        builder: (context, value, child) {
                                          return Text(
                                            formatDateTime(
                                                  dateTime: value,
                                                  format: "dd-MM-yyyy",
                                                ) ??
                                                '',
                                            style: TextStyle(fontSize: 14),
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
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
                                  'ধর্ম',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: () {
                                  _openBottomSheet(religionList, 'religion');
                                },
                                child: Container(
                                  width: 230,
                                  height:
                                      30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: religion,
                                        builder: (context, value, child) {
                                          return Text(
                                            value,
                                            style: TextStyle(fontSize: 14),
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
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
                              GestureDetector(
                                onTap: () {
                                  _openBottomSheet(sexList, 'gender');
                                },
                                child: Container(
                                  width: 230,
                                  height:
                                      30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: gender,
                                        builder: (context, value, child) {
                                          return Text(
                                            value,
                                            style: TextStyle(fontSize: 14),
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          profileInfoList(
                            context,
                            "রক্তের গ্রুপ",
                            bloodGroupController,
                          ),
                          profileInfoList(
                            context,
                            "স্থায়ী ঠিকানা",
                            permanentAddressController,
                            isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "পোস্ট কোড",
                            zipCodeController,
                            // isMultiLine: true,
                          ),

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
                              GestureDetector(
                                onTap: () {
                                  _openBottomSheet(
                                    divisionList,
                                    'permanentAddressDivision',
                                  );
                                },
                                child: Container(
                                  width: 230,
                                  height:
                                      30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable:
                                            permanentAddressDivision,
                                        builder: (context, value, child) {
                                          return Text(
                                            value,
                                            style: TextStyle(fontSize: 14),
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
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
                            "পোস্ট কোড",
                            presentZipCodeController,
                            // isMultiLine: true,
                          ),

                          profileInfoList(
                            context,
                            "থানা",
                            presentThanaController,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 90,
                                child: Text(
                                  'বিভাগ',
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: () {
                                  _openBottomSheet(
                                    divisionList,
                                    'presentAddressDivision',
                                  );
                                },
                                child: Container(
                                  width: 230,
                                  //padding:EdgeInsets.symmetric(horizontal: 40),
                                  height:
                                      30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable: presentAddressDivision,
                                        builder: (context, value, child) {
                                          return Text(
                                            value,
                                            style: AppTextStyles.normalLight(context),
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          profileInfoList(context, "পিতার নাম", fatherNameController),
                          profileInfoList(
                            context,
                            "জাতীয় পরিচয়পত্র নং",
                            fatherNidController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "মোবাইল নম্বর",
                            fatherPhoneController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "মাতার নাম",
                            motherNameController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "জাতীয় পরিচয়পত্র নং",
                            motherNidController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "মোবাইল নম্বর",
                            motherPhoneController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "স্থানীয় গার্ডিয়ানের নাম",
                            localGuardianController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "জাতীয় পরিচয়পত্র নং",
                            localGuardianNidController,
                            // isMultiLine: true,
                          ),
                          profileInfoList(
                            context,
                            "মোবাইল নম্বর",
                            localGuardianPhoneController,
                            // isMultiLine: true,
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
                        final studentProfileUpdateRequestModel =
                            StudentProfileUpdateRequestModel(
                              dobNo: birthRegNo.text.trim(),
                              dobDate: selectedDate.value,
                              religion: religion.value,
                              gender: gender.value,
                              bloodGroup: bloodGroupController.text.trim(),
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

                              // fatherPhone: fatherPhoneController.text.trim(),
                              fatherPhone:
                                  fatherPhoneController.text.trim() ==
                                      (studentProfile?.fatherPhone ?? "").trim()
                                  ? null
                                  : fatherPhoneController.text.trim(),

                              motherName: motherNameController.text.trim(),
                              motherNidNo: motherNidController.text.trim(),

                              //motherPhone: motherPhoneController.text.trim(),
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

                              // emergencyPhoneNo: localGuardianPhoneController.text.trim(),
                              /*  emergencyPhoneNo:  localGuardianPhoneController.text.trim() ==
                                (studentProfile?.localGuardianPhone ?? "").trim()
                                ? null
                                : localGuardianPhoneController.text.trim(),*/
                              localGuardianRelation:
                                  studentProfile?.localGuardianRelation,

                              //localGuardianPhone: localGuardianPhoneController.text.trim(),
                              localGuardianPhone:
                                  localGuardianPhoneController.text.trim() ==
                                      (studentProfile?.localGuardianPhone ?? "")
                                          .trim()
                                  ? null
                                  : localGuardianPhoneController.text.trim(),

                              presentDivision: presentAddressDivision.value,

                              // phone: studentProfile!.phone,
                              name: studentProfile!.name,
                              is2FaOn: false,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // আজকের তারিখ
      firstDate: DateTime(1900), // শুরুর সীমা
      lastDate: DateTime(2100), // শেষ সীমা
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple, // হেডার রঙ
              onPrimary: Colors.white, // হেডারের টেক্সট রঙ
              onSurface: Colors.black, // বডির টেক্সট রঙ
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  final List<String> religionList = [
    "ইসলাম",
    "হিন্দু",
    "বৌদ্ধ",
    "খ্রিষ্টান",
    "অন্যান্য",
  ];
  final List<String> sexList = ["পুরুষ", "মহিলা", "অন্যান্য"];

  final List<String> divisionList = [
    "ঢাকা",
    "চট্টগ্রাম",
    "রাজশাহী",
    "খুলনা",
    "বরিশাল",
    "সিলেট",
    "রংপুর",
    "ময়মনসিংহ",
  ];
  void _openBottomSheet(List selectedList, String value) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: selectedList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(selectedList[index]),
              onTap: () {
                if (value == 'religion') {
                  religion.value = selectedList[index];
                } else if (value == 'gender') {
                  gender.value = selectedList[index];
                } else if (value == 'permanentAddressDivision') {
                  permanentAddressDivision.value = selectedList[index];
                } else if (value == 'presentAddressDivision') {
                  presentAddressDivision.value = selectedList[index];
                }
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
