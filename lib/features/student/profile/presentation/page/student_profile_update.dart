import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:school_management/core/constants/app_urls.dart';

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
  TextEditingController localGuardianEmaPhoneController = TextEditingController();


  XFile? photo;
  String networkImage = '';
  StudentProfileResponseModel? studentProfile;
  String? religion='ধর্ম নির্বাচন করুন';
  String? gender='লিঙ্গ নির্বাচন করুন';
  String? permanentAddressDivision='বিভাগ নির্বাচন করুন';
  String? presentAddressDivision='বিভাগ নির্বাচন করুন';
  String? selectedDate;


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
          //StudentProfileUpdateRequestModel? teacherProfile;

          if (state is StudentProfileSuccess) {
            studentProfile = state.studentProfileResponseModel;
            birthRegNo.text =studentProfile!.dobNo??'';
            bloodGroupController.text =studentProfile!.bloodGroup??'';
            permanentAddressController.text = studentProfile!.permanentAddress??'';
            zipCodeController.text = studentProfile!.permanentPostalCode??'';
            presentZipCodeController.text = studentProfile!.presentPostalCode??'';
            thanaController.text = studentProfile!.permanentThana??'';
            presentAddressController.text = studentProfile!.presentAddress??'';
            presentThanaController.text = studentProfile!.presentThana??'';
            fatherNameController.text = studentProfile!.fatherName??'';
            fatherNidController.text = studentProfile!.fatherNidNo??'';
            fatherPhoneController.text = studentProfile!.fatherPhone??'';
            motherNameController.text = studentProfile!.motherName??'';
            motherNidController.text = studentProfile!.motherNidNo??'';
            motherPhoneController.text = studentProfile!.motherPhone??'';
            localGuardianController.text = studentProfile!.localGuardianName??'';
            localGuardianNidController.text = studentProfile!.localGuardianNidNo??'';
            localGuardianPhoneController.text = studentProfile!.localGuardianPhone??'';
            gender=studentProfile!.gender??'লিঙ্গ নির্বাচন করুন';
            religion=studentProfile!.religion??'ধর্ম নির্বাচন করুন';
            permanentAddressDivision=studentProfile!.permanentDivision??'বিভাগ নির্বাচন করুন';
            presentAddressDivision=studentProfile!.presentDivision??'বিভাগ নির্বাচন করুন';
          //  localGuardianEmaPhoneController.text = studentProfile!.loca??'';
           /* phoneController.text = teacherProfile.phone.toString();
            emailController.text = teacherProfile.email.toString();
            fatherNameController.text = teacherProfile.fatherName.toString();
            motherNameController.text = teacherProfile.motherName.toString();
            presentAddressController.text = teacherProfile.presentAddress
                .toString();
            permanentAddressController.text = teacherProfile.permanentAddress
                .toString();
            bloodGroupController.text = teacherProfile.bloodGroup.toString();
            final serverPhoto = teacherProfile.photo;
            networkImage =
            (serverPhoto == null ||
                serverPhoto.isEmpty ||
                serverPhoto.contains("https://shorturl.at"))
                ? 'https://shorturl.at/RfnsS'
                : serverPhoto;
            debugPrint("======== photo url ======  ${AppUrls.imageUrl}");
            log("======== photo ======  $serverPhoto");*/
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    
                                      /*Text(
                                        studentProfile?.phone ?? "Unknown",
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
                                            studentProfile?.email ?? "Unknown",
                                            style: AppTextStyles.normalLight(
                                              context,
                                            ).copyWith(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),*/
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
                                  style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: (){
                                  _selectDate(context);
                                },
                                child: Container(
                                  width: 250,
                                  height: 30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(selectedDate??'', style: TextStyle(fontSize: 14)),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                    
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'ধর্ম',
                                  style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: (){
                                   _openBottomSheet(religionList,'religion');
                                    },
                                child: Container(
                                  width: 250,
                                  height: 30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(religion!, style: TextStyle(fontSize: 14)),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                    
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'লিঙ্গ',
                                  style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: (){
                                  _openBottomSheet(sexList,'gender');
                                },
                                child: Container(
                                  width: 250,
                                  height: 30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(gender!, style: TextStyle(fontSize: 14)),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                    
                                ),
                              )
                            ],
                          ),
                    
                          profileInfoList(context, "রক্তের গ্রুপ", bloodGroupController),
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
                    
                          profileInfoList(
                            context,
                            "থানা",
                            thanaController,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child: Text(
                                  'বিভাগ',
                                  style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: (){
                                  _openBottomSheet(divisionList,'permanentAddressDivision');
                                },
                                child: Container(
                                  width: 250,
                                  height: 30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(permanentAddressDivision!, style: TextStyle(fontSize: 14)),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                    
                                ),
                              )
                            ],
                          ),
                          profileInfoList(
                            context,
                            "বর্তমান ঠিকানা",
                            permanentAddressController,
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
                                width: 100,
                                child: Text(
                                  'বিভাগ',
                                  style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
                                ),
                              ),
                              const Text(" : "),
                              GestureDetector(
                                onTap: (){
                                  _openBottomSheet(divisionList,'presentAddressDivision');
                                },
                                child: Container(
                                  width: 250,
                                  height: 30, // 👈 matches your screenshot style
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(presentAddressDivision!, style: TextStyle(fontSize: 14)),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                    
                                ),
                              )
                            ],
                          ),
                          profileInfoList(
                            context,
                            "পিতার নাম",
                            fatherNameController,
                            // isMultiLine: true,
                          ),
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

                        final studentProfileUpdateRequestModel =StudentProfileUpdateRequestModel(
                          dobNo: birthRegNo.text.trim(),
                          dobDate: selectedDate,
                          religion: religion,
                          gender: gender,
                          bloodGroup: bloodGroupController.text.trim(),
                          permanentAddress: permanentAddressController.text.trim(),
                          permanentPostalCode: zipCodeController.text.trim(),
                          permanentThana: thanaController.text.trim(),
                          permanentDivision: permanentAddressDivision,
                          presentAddress: presentAddressController.text.trim(),
                          presentThana: presentThanaController.text.trim(),
                          presentPostelCode: presentZipCodeController.text.trim(),
                          fatherName: fatherNameController.text.trim(),
                          fatherNidNo: fatherNidController.text.trim(),

                         // fatherPhone: fatherPhoneController.text.trim(),

                            fatherPhone:  fatherPhoneController.text.trim() ==
                                (studentProfile?.fatherPhone ?? "").trim()
                                ? null
                                : fatherPhoneController.text.trim(),


                          motherName: motherNameController.text.trim(),
                          motherNidNo: motherNidController.text.trim(),

                          //motherPhone: motherPhoneController.text.trim(),

                            motherPhone:  motherPhoneController.text.trim() ==
                                (studentProfile?.motherPhone ?? "").trim()
                                ? null
                                : motherPhoneController.text.trim(),


                          localGuardianName: localGuardianController.text.trim(),
                          localGuardianNidNo: localGuardianNidController.text.trim(),

                         // emergencyPhoneNo: localGuardianPhoneController.text.trim(),
                          /*  emergencyPhoneNo:  localGuardianPhoneController.text.trim() ==
                                (studentProfile?.localGuardianPhone ?? "").trim()
                                ? null
                                : localGuardianPhoneController.text.trim(),*/


                          localGuardianRelation: studentProfile!.localGuardianRelation,


                          //localGuardianPhone: localGuardianPhoneController.text.trim(),
                            localGuardianPhone:  localGuardianPhoneController.text.trim() ==
                                (studentProfile?.localGuardianPhone ?? "").trim()
                                ? null
                                : localGuardianPhoneController.text.trim(),


                          presentDivision: presentAddressDivision,

                         // phone: studentProfile!.phone,
                          name: studentProfile!.name,
                            is2FaOn:false

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



                       /* final teacherProfileUpdateRequestModel =
                        StudentProfileUpdateRequestModel(
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
                          bloodGroup: bloodGroupController.text,
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
                        );*/
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
      firstDate: DateTime(1900),  // শুরুর সীমা
      lastDate: DateTime(2100),   // শেষ সীমা
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple, // হেডার রঙ
              onPrimary: Colors.white,    // হেডারের টেক্সট রঙ
              onSurface: Colors.black,    // বডির টেক্সট রঙ
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
         selectedDate = DateFormat('yyyy-MM-dd').format(picked); // 👈 formatted;
      });
    }
  }

  final List<String> religionList = [
    "ইসলাম",
    "হিন্দু",
    "বৌদ্ধ",
    "খ্রিষ্টান",
    "অন্যান্য",
  ];
  final List<String> sexList = [
    "পুরুষ",
    "মহিলা",
    "অন্যান্য",
  ];

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
  void _openBottomSheet(List selectedList,String value) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return
           ListView.builder(
            itemCount: selectedList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedList[index]),
                onTap: () {
                  setState(() {
                    if(value=='religion'){
                      religion=selectedList[index];
                    }else if(value=='gender'){
                      gender=selectedList[index];
                    }else if(value=='permanentAddressDivision'){
                      permanentAddressDivision=selectedList[index];
                    }else{
                      presentAddressDivision = selectedList[index];
                    }

                  });
                  Navigator.pop(context);
                },
              );
            },
          );

      },
    );
  }
}
