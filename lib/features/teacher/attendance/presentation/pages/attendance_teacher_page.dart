import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_enum.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/constants/app_text_styles.dart';
import 'package:school_management/core/widgets/app_bar.dart';
import 'package:school_management/features/teacher/attendance/data/model/attendance_model.dart';
import 'package:school_management/features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
import '../../../../../core/widgets/app_empty.dart';

class AttendanceTeacherPage extends StatefulWidget {
  final AttendanceModel attendanceModel;
  const AttendanceTeacherPage({super.key, required this.attendanceModel});

  @override
  State<AttendanceTeacherPage> createState() => _AttendanceTeacherPageState();
}

class _AttendanceTeacherPageState extends State<AttendanceTeacherPage> {
  Color getStatusColor(String status) {
    switch (status) {
      case "উপস্থিত":
        return Colors.green;
      case "অনুপস্থিত":
        return Colors.red;
      case "সিদ্ধান্ত হয়নি":
        return Colors.black87;
      case "ছুটি":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  final List<String> options = ["উপস্থিত", "অনুপস্থিত", "সিদ্ধান্ত হয়নি"];

  final ValueNotifier<DateTime> attendanceDate = ValueNotifier(DateTime.now());

  void showStatusBottomSheet(BuildContext context, List<String> items) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.map((option) {
              return InkWell(
                onTap: () {
                  Navigator.pop(context);
                  print("Selected: $option");
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    DateTime today = DateTime.now();
    DateTime onlyDate = DateTime(today.year, today.month, today.day);
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

              /// New Add Button
              Container(
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
              ),

              /// Date + Subject + Filter Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //!date picker
                  ValueListenableBuilder(
                    valueListenable: attendanceDate,
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () async {
                          //showDateDialog(context);
                          await pickAdaptiveDate(
                            context: context,
                            notifier: attendanceDate,
                            initialDate: value,
                            firstDate: DateTime(DateTime.now().year - 1),
                            lastDate: DateTime.now(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffd9d9d9),
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
                              const SizedBox(width: 4),
                              Text(
                                "${formatDateTime(dateTime: value, format: "yyyy-MM-dd")}",
                                style: AppTextStyles.normalLight(
                                  context,
                                ).copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  //! subject choice
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffd9d9d9),
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
                        const SizedBox(width: 4),
                        Text(
                          "সাবজেক্ট",
                          style: AppTextStyles.normalLight(
                            context,
                          ).copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  //! Filter Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "ফিল্টার",
                      style: AppTextStyles.normalBold(
                        context,
                      ).copyWith(fontSize: 16, color: AppColors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //!for attendance list
              BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
                builder: (context, state) {
                  if (state is GetStudentListLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is GetStudentListError) {
                    return Center(child: AppEmpty(msg: state.message));
                  } else if (state is GetStudentListSuccess) {
                    final studentList = state.studentListResponseTeacherModel;

                    return Container(
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
                            itemCount: studentList.length,
                            itemBuilder: (context, index) {
                              final student = studentList[index];

                              final status = attendanceStatusFromString(
                                student.status!,
                              );

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
                                        status.value,
                                        style: AppTextStyles.normalBold(context)
                                            .copyWith(
                                              color: AppColors
                                                  .statusColors[student.status],
                                              fontSize: 10,
                                            ),
                                      ),
                                    ),

                                    /// Action Button
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: () {
                                            showStatusBottomSheet(
                                              context,
                                              options,
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  AppSizes.insidePadding - 2,
                                              vertical:
                                                  AppSizes.insidePadding - 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: AppColors.blue,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "পরিবর্তন",
                                              style: AppTextStyles.normalLight(
                                                context,
                                              ).copyWith(fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
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
