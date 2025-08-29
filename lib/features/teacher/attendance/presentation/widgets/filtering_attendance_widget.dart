import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/utilities/app_filtering_bottom_sheet.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
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

  final ValueNotifier<BranchResponseModel?> selectedBranch = ValueNotifier(
    null,
  );
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

        //!select branch
        InkWell(
          onTap: () => pickBranch(context),
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
                ValueListenableBuilder<BranchResponseModel?>(
                  valueListenable: selectedBranch,
                  builder: (context, value, child) {
                    return Text(
                      value?.name ?? "শাখা",
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
                branchId: selectedBranch.value?.id,
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

  Future<void> pickBranch(BuildContext context) async {
    final selected = await filteringBottomSheet<BranchResponseModel>(
      context: context,
      bloc: context.read<BranchBloc>(),
      event: GetBranchListEvent(),
      extractItems: (state) =>
          state is GetBranchListSuccess ? state.branchResponseModel : null,
      getTitle: (s) => s.name ?? "Unknown",
      emptyText: "কোনো শাখা পাওয়া যায়নি",
    );

    if (selected != null) selectedBranch.value = selected;
  }
}
