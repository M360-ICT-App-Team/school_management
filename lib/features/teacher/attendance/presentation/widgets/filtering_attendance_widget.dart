import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
import '../../../../../core/widgets/app_bottom_list_sheet.dart';
import '../../../../common/subject/data/model/subject_list_response_teacher_model.dart';
import '../../../../common/subject/presentation/bloc/subject_bloc.dart';
import '../../../branch/data/model/branch_response_model.dart';
import '../../../branch/presentation/bloc/branch_bloc.dart';
import '../../data/model/attendance_model.dart';
import '../bloc/teacher_attendance_bloc.dart';

class FilteringAttendanceWidget extends StatefulWidget {
  final AttendanceModel attendanceModel;

  const FilteringAttendanceWidget({super.key, required this.attendanceModel});

  @override
  State<FilteringAttendanceWidget> createState() =>
      _FilteringAttendanceWidgetState();
}

class _FilteringAttendanceWidgetState extends State<FilteringAttendanceWidget> {
  final ValueNotifier<DateTime> attendanceDate = ValueNotifier(DateTime.now());
  final ValueNotifier<String?> selectedSubject = ValueNotifier(null);
  final ValueNotifier<int?> selectedSubjectId = ValueNotifier(null);

  final ValueNotifier<String?> selectedBranch = ValueNotifier(null);
  final ValueNotifier<int?> selectedBranchId = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //!date picker
        ValueListenableBuilder(
          valueListenable: attendanceDate,
          builder: (context, value, child) {
            return InkWell(
              onTap: () async {
                await pickAdaptiveDate(
                  context: context,
                  notifier: attendanceDate,
                  initialDate: value,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime.now(),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
        InkWell(
          onTap: () async {
            context.read<SubjectBloc>().add(GetSubjectEvent());

            final selected =
                await showSelectionBottomSheet<SubjectListResponseTeacherModel>(
                  context: context,
                  builder: (ctx, onSelect) {
                    return BlocBuilder<SubjectBloc, SubjectState>(
                      builder: (context, state) {
                        if (state is GetSubjectLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is GetSubjectSuccess) {
                          final subjects = state.subjectResponseModel;
                          if (subjects.isEmpty) {
                            return const Center(
                              child: Text("কোনো সাবজেক্ট পাওয়া যায়নি"),
                            );
                          }

                          return ListView.builder(
                            itemCount: subjects.length,
                            itemBuilder: (context, index) {
                              final subject = subjects[index];
                              return ListTile(
                                title: Text(subject.subjectName ?? "unknown"),
                                onTap: () => onSelect(subject),
                              );
                            },
                          );
                        } else if (state is GetSubjectError) {
                          return const Center(
                            child: Text("কোনো সাবজেক্ট পাওয়া যায়নি"),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                );

            if (selected != null) {
              selectedSubject.value = selected.subjectName;
              selectedSubjectId.value = selected.subjectOfferingId;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
                ValueListenableBuilder<String?>(
                  valueListenable: selectedSubject,
                  builder: (context, value, child) {
                    return Text(
                      value ?? "সাবজেক্ট", // সিলেক্ট করা সাবজেক্ট দেখাবে
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

        //!select branch
        InkWell(
          onTap: () async {
            context.read<BranchBloc>().add(GetBranchListEvent());

            final selected =
                await showSelectionBottomSheet<BranchResponseModel>(
                  context: context,
                  builder: (ctx, onSelect) {
                    return BlocBuilder<BranchBloc, BranchState>(
                      builder: (context, state) {
                        if (state is GetBranchListLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is GetBranchListSuccess) {
                          final branches = state.branchResponseModel;
                          return ListView.builder(
                            itemCount: branches.length,
                            itemBuilder: (context, index) {
                              final branch = branches[index];
                              return ListTile(
                                title: Text(branch.name ?? "unknown"),
                                onTap: () => onSelect(
                                  branch,
                                ), // <-- পুরো object পাঠাচ্ছি
                              );
                            },
                          );
                        } else if (state is GetBranchListError) {
                          return const Center(
                            child: Text("কোনো শাখা পাওয়া যায়নি"),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                );

            if (selected != null) {
              selectedBranch.value = selected.name;
              selectedBranchId.value = selected.id;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
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
                ValueListenableBuilder<String?>(
                  valueListenable: selectedBranch,
                  builder: (context, value, child) {
                    return Text(
                      value ?? "শাখা",
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

        //! Filter Button
        InkWell(
          onTap: () {
            context.read<TeacherAttendanceBloc>().add(
              GetStudentListEvent(
                id: widget.attendanceModel.batchId,
                subjectId: widget.attendanceModel.subjectId,
                branchId: selectedBranchId.value,
                date: attendanceDate.value,
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
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
        ),
      ],
    );
  }
}
