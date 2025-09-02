import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_empty.dart';
import '../../data/model/student_single_semester_list_model.dart';

class StudentAttendanceListWidget extends StatefulWidget {
  final List<StudentSingleSemesterListModel> singleSemesterData;

  const StudentAttendanceListWidget(
      {super.key, required this.singleSemesterData});

  @override
  State<StudentAttendanceListWidget> createState() =>
      _StudentAttendanceListWidgetState();
}

class _StudentAttendanceListWidgetState
    extends State<StudentAttendanceListWidget> {
  Color? getAttendanceColor(String status) {
    switch (status.toLowerCase()) {
      case "absent":
        return AppColors.statusColors['absent'];
      case "late":
        return AppColors.statusColors['late'];
      case "present":
        return AppColors.statusColors['present'];
      default:
        return AppColors.statusColors['no_action'];
    }
  }


  @override
  Widget build(BuildContext context) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.insidePadding,
                  vertical: AppSizes.insidePadding - 2,
                ),
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
                          bottom: BorderSide(color: AppColors.blue, width: 1.5),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: AppSizes.insidePadding * 1,
                              ),
                              child: Text(
                                "বিষয়",
                                style: AppTextStyles.normalBold(
                                  context,
                                ).copyWith(color: AppColors.blue),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "উপস্থিতি",
                              style: AppTextStyles.normalBold(
                                context,
                              ).copyWith(color: AppColors.blue),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "স্ট্যাটাস",
                              textAlign: TextAlign.end,
                              style: AppTextStyles.normalBold(
                                context,
                              ).copyWith(color: AppColors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //!Student Attendance List
                    widget.singleSemesterData.isEmpty?Expanded(child: AppEmpty(msg: 'No data found')):
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.singleSemesterData.length,
                        itemBuilder: (context, index) {
                          final singleSemester = widget.singleSemesterData[index];

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.insidePadding,
                              vertical: AppSizes.insidePadding,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: AppColors.blue.withAlpha(40),
                                    width: 1),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                               //! Subject -------
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: AppSizes.insidePadding * 1,
                                    ),
                                    child: Text(
                                      singleSemester.subjectName!,
                                    ),
                                  ),
                                ),
                                //! Date -------
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                      DateFormat(
                                        "yyyy-MM-dd",
                                      ).format(singleSemester.attendanceTime!)
                                  ),
                                ),
                                //! Status -------
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                  attendanceStatusFromString(
                                  singleSemester.status!,
                                ).value,

                                    textAlign: TextAlign.end,
                                    style: AppTextStyles.normalBold(
                                      context,
                                    ).copyWith(color: getAttendanceColor(singleSemester.status!)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )

                  ],
                ),
              ),
            ),
          );

        }




  }

