import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/widgets/app_empty.dart';
import 'package:school_management/features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_filtering_bottom_sheet.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../common/subject/data/model/subject_list_response_teacher_model.dart';
import '../../../../common/subject/presentation/bloc/subject_bloc.dart';
import '../../../branch/presentation/bloc/branch_bloc.dart';
import '../widgets/select_batch_teacher_card_widget.dart';

class SelectBatchTeacherPage extends StatefulWidget {
  const SelectBatchTeacherPage({super.key});

  @override
  State<SelectBatchTeacherPage> createState() => _SelectBatchTeacherPageState();
}

class _SelectBatchTeacherPageState extends State<SelectBatchTeacherPage> {
  final ValueNotifier<SubjectListResponseTeacherModel?> selectedSubject =
      ValueNotifier(null);

  final ValueNotifier<DateTimeRange?> selectedDateRange = ValueNotifier(null);
  int? branchId;

  @override
  void initState() {
    super.initState();
    context.read<TeacherAttendanceBloc>().add(GetTeacherBatchOverViewEvent());
    context.read<BranchBloc>().add(GetBranchListEvent());
  }

  Future<void> pickDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange:
          selectedDateRange.value ??
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
    );

    if (picked != null) {
      selectedDateRange.value = picked;
    }
  }

  Future<void> pickSubject(BuildContext context) async {
    final selected =
        await filteringBottomSheet<SubjectListResponseTeacherModel>(
          context: context,
          bloc: context.read<SubjectBloc>(),
          event: GetSubjectEvent(),
          extractItems: (state) =>
              state is GetSubjectSuccess ? state.subjectResponseModel : null,
          getTitle: (s) => s.subjectName ?? "Unknown",
          emptyText: "কোনো সাবজেক্ট পাওয়া যায়নি",
        );

    if (selected != null) selectedSubject.value = selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.insidePadding,
          horizontal: AppSizes.insidePadding,
        ),
        child: Column(
          children: [
            //! Subject এবং Date Range এক Row-এ
            Row(
              children: [
                //! Subject Dropdown
                Expanded(
                  child: InkWell(
                    onTap: () => pickSubject(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.insidePadding,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
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
                          const SizedBox(width: 6),
                          Expanded(
                            child:
                                ValueListenableBuilder<
                                  SubjectListResponseTeacherModel?
                                >(
                                  valueListenable: selectedSubject,
                                  builder: (context, value, child) {
                                    return Text(
                                      value?.subjectName ?? "সাবজেক্ট",
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.normalLight(
                                        context,
                                      ).copyWith(fontSize: 14),
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                //! Date Range Picker
                Expanded(
                  child: InkWell(
                    onTap: () => pickDateRange(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.insidePadding,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: ValueListenableBuilder<DateTimeRange?>(
                              valueListenable: selectedDateRange,
                              builder: (context, value, child) {
                                return Text(
                                  value == null
                                      ? "তারিখ"
                                      : "${value.start.toLocal().toString().split(' ')[0]} - ${value.end.toLocal().toString().split(' ')[0]}",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.normalLight(
                                    context,
                                  ).copyWith(fontSize: 14),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                //! Filter Button
                InkWell(
                  onTap: () {
                    context.read<TeacherAttendanceBloc>().add(
                      GetTeacherBatchOverViewEvent(
                        subjectId: selectedSubject.value?.id,
                        selectedDateRange: selectedDateRange.value,
                      ),
                    );
                  },
                  child: Container(
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
                ),
              ],
            ),

            const SizedBox(height: 10),

            //! for building batch list
            Expanded(
              child: BlocBuilder<BranchBloc, BranchState>(
                buildWhen: (previous, current) =>
                    current is GetBranchListLoading ||
                    current is GetBranchListSuccess ||
                    current is GetBranchListError,
                builder: (context, state) {
                  log("=======Branch State======= : $state");
                  if (state is GetBranchListLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is GetBranchListSuccess) {
                    branchId ??= state.branchResponseModel[0].id;

                    return BlocBuilder<
                      TeacherAttendanceBloc,
                      TeacherAttendanceState
                    >(
                      buildWhen: (previous, current) =>
                          current is GetTeacherBatchOverViewLoading ||
                          current is GetTeacherBatchOverViewSuccess ||
                          current is GetTeacherBatchOverViewError,
                      builder: (context, teacherState) {
                        log("=======Teacher State======= : $teacherState");
                        if (branchId != null) {
                          return buildBatchList(teacherState, branchId!);
                        }
                        return const Center(
                          child: AppEmpty(msg: "Branch not found"),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: AppEmpty(msg: "Something went wrong"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBatchList(TeacherAttendanceState state, int branchId) {
    if (state is GetTeacherBatchOverViewLoading) {
      return const Center(child: CircularProgressIndicator.adaptive());
    } else if (state is GetTeacherBatchOverViewError) {
      return Center(child: AppEmpty(msg: state.message));
    } else if (state is GetTeacherBatchOverViewSuccess) {
      if (state.batchOverViewTeacherResponseModel.isEmpty) {
        return const Center(child: AppEmpty(msg: "No batch found"));
      }
      return ListView.builder(
        itemCount: state.batchOverViewTeacherResponseModel.length,
        itemBuilder: (context, index) {
          final batch = state.batchOverViewTeacherResponseModel[index];
          return SelectBatchTeacherCardWidget(
            batchOverViewTeacherResponseModel: batch,
            branchId: branchId,
          );
        },
      );
    }
    return const Center(child: AppEmpty(msg: "Something went wrong"));
  }
}
