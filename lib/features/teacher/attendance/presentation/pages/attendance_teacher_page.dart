import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_enum.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/constants/app_text_styles.dart';
import 'package:school_management/core/widgets/app_bar.dart';
import 'package:school_management/features/teacher/attendance/data/model/attendance_model.dart';
import 'package:school_management/features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';
import 'package:school_management/features/teacher/attendance/presentation/widgets/create_and_update_attendance_button_widget.dart';

import '../../../../../core/widgets/app_empty.dart';

import '../../../../../core/widgets/app_snackbar.dart';
import '../../../branch/data/model/branch_response_model.dart';
import '../widgets/filtering_attendance_widget.dart';

class AttendanceTeacherPage extends StatefulWidget {
  final AttendanceModel attendanceModel;
  const AttendanceTeacherPage({super.key, required this.attendanceModel});

  @override
  State<AttendanceTeacherPage> createState() => _AttendanceTeacherPageState();
}

class _AttendanceTeacherPageState extends State<AttendanceTeacherPage> {
  final ValueNotifier<DateTime> attendanceDate = ValueNotifier(DateTime.now());

  final ValueNotifier<String> selectedOption = ValueNotifier("present");
  final ValueNotifier<BranchResponseModel?> selectedBranch = ValueNotifier(
    null,
  );
  @override
  void initState() {
    DateTime onlyDate = DateTime(
      attendanceDate.value.year,
      attendanceDate.value.month,
      attendanceDate.value.day,
    );
    super.initState();
    context.read<TeacherAttendanceBloc>().add(
      GetStudentListEvent(
        id: widget.attendanceModel.batchId,
        date: onlyDate,
        subjectId: widget.attendanceModel.subjectId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.insidePadding,
            vertical: AppSizes.insidePadding * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "হাজিরা",
                style: AppTextStyles.normalBold(context).copyWith(
                  fontSize: 22,
                  color: AppColors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.blue,
                ),
              ),
              const SizedBox(height: 16),

              //! for filtering widget
              FilteringAttendanceWidget(
                attendanceModel: widget.attendanceModel,
                attendanceDate: attendanceDate,
                selectedBranch: selectedBranch,
              ),

              const SizedBox(height: 16),

              //!for attendance list
              BlocConsumer<TeacherAttendanceBloc, TeacherAttendanceState>(
                buildWhen: (previous, current) =>
                    current is GetStudentListLoading ||
                    current is GetStudentListSuccess ||
                    current is GetStudentListError,

                listener: (context, state) {
                  log("==========state attendance=-=====: $state");
                  if (state is CreateAttendanceTeacherLoading) {
                    AppBottomSheets.showLoading(
                      context,
                      message: "Please wait...",
                    );
                  } else if (state is CreateAttendanceTeacherSuccess) {
                    AppBottomSheets.hide(context);
                    context.read<TeacherAttendanceBloc>().add(
                      GetStudentListEvent(
                        id: widget.attendanceModel.batchId,
                        subjectId: widget.attendanceModel.subjectId,
                        branchId: selectedBranch.value?.id,
                        date: attendanceDate.value,
                      ),
                    );
                    AppBottomSheets.showSuccess(
                      context,
                      message: "Attendance Created",
                    );
                  } else if (state is CreateAttendanceTeacherError) {
                    AppBottomSheets.hide(context);
                    AppBottomSheets.showError(context, message: state.message);
                  } else if (state is UpdateAttendanceTeacherLoading) {
                    AppBottomSheets.showLoading(
                      context,
                      message: "Please wait...",
                    );
                  } else if (state is UpdateAttendanceTeacherSuccess) {
                    AppBottomSheets.hide(context);
                    context.read<TeacherAttendanceBloc>().add(
                      GetStudentListEvent(
                        id: widget.attendanceModel.batchId,
                        subjectId: widget.attendanceModel.subjectId,
                        branchId: selectedBranch.value?.id,
                        date: attendanceDate.value,
                      ),
                    );
                    AppBottomSheets.showSuccess(
                      context,
                      message: "Attendance Updated",
                    );
                  } else if (state is UpdateAttendanceTeacherError) {
                    AppBottomSheets.hide(context);
                    AppBottomSheets.showError(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is GetStudentListLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is GetStudentListError) {
                    return Center(child: AppEmpty(msg: state.message));
                  } else if (state is GetStudentListSuccess) {
                    final studentList =
                        state.studentListResponseTeacherModel.attendanceList;

                    final studentAttendanceModel =
                        state.studentListResponseTeacherModel;

                    return SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.blue, width: 2),
                        ),
                        child: Column(
                          children: [
                            //! Header Row
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSizes.insidePadding,
                                vertical: AppSizes.insidePadding - 2,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.blue,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: AppSizes.insidePadding * 4,
                                      ),
                                      child: Text(
                                        "আইডি",
                                        style: AppTextStyles.normalBold(
                                          context,
                                        ).copyWith(color: AppColors.blue),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "উপস্থিতি",
                                      style: AppTextStyles.normalBold(
                                        context,
                                      ).copyWith(color: AppColors.blue),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "একশন",
                                      textAlign: TextAlign.end,
                                      style: AppTextStyles.normalBold(
                                        context,
                                      ).copyWith(color: AppColors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      
                            //! Student Rows with ListView.builder
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: studentList!.length,
                              itemBuilder: (context, index) {
                                final student = studentList[index];
                      
                                final attendanceStatus = student.status!.value;
                      
                                if (student.status!.value == "no_action") {
                                  student.status!.value = "present";
                                }
                                log("student status: ${student.status!.value}");
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.insidePadding,
                                    vertical: AppSizes.insidePadding,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.blue.withAlpha(40),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //! Name + ID + Avatar
                                      Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColors.blue,
                                              child: const Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    student.studentName ??
                                                        "Unknown",
                                                    style:
                                                        AppTextStyles.normalLight(
                                                          context,
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                  Text(
                                                    student.rollNo ?? "Unknown",
                                                    style:
                                                        AppTextStyles.normalLight(
                                                          context,
                                                        ).copyWith(fontSize: 12),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                      
                                      /// Status
                                      Expanded(
                                        child: Text(
                                          attendanceStatusFromString(
                                            attendanceStatus,
                                          ).value,
                                          style: AppTextStyles.smallBold(context)
                                              .copyWith(
                                                color: AppColors.status(
                                                  attendanceStatus.toLowerCase(),
                                                ),
                                              ),
                                        ),
                                      ),
                      
                                      //!for update and create attendance
                                      CreateAndUpdateAttendanceButtonWidget(
                                        studentListResponseTeacherModel:
                                            studentAttendanceModel,
                                        selectedOption: selectedOption,
                                        student: student,
                                      ),
                                      //!end of create and update attendance
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: AppSizes.insidePadding),
                            studentAttendanceModel.isSubmitted == false
                                ? SizedBox(
                                    width: 140,
                                    height: 40,
                                    child: FilledButton(
                                      style: FilledButton.styleFrom(
                                        backgroundColor: AppColors.blue,
                                      ),
                                      onPressed: () {
                                        context.read<TeacherAttendanceBloc>().add(
                                          CreateAttendanceTeacherEvent(
                                            attendanceListModel: studentList,
                                            subjectOfferingId:
                                                widget.attendanceModel.subjectId,
                                            date: attendanceDate.value,
                                            batchSemesterId:
                                                widget.attendanceModel.batchId,
                                          ),
                                        );
                                      },
                                      child: Text("নিশ্চিত করুন"),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: AppEmpty(msg: "Something went wrong"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
