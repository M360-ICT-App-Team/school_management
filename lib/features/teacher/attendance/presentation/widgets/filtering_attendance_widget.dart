import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
import '../../../../../core/widgets/app_bottom_list.dart';
import '../../../branch/data/model/branch_response_model.dart';
import '../../../branch/presentation/bloc/branch_bloc.dart';
import '../../data/model/attendance_model.dart';
import '../bloc/teacher_attendance_bloc.dart';

class FilteringAttendanceWidget extends StatefulWidget {
  final AttendanceModel attendanceModel;
  final ValueNotifier<DateTime> attendanceDate;
  final ValueNotifier<BranchResponseModel?> selectedBranch;

  const FilteringAttendanceWidget({
    super.key,
    required this.attendanceModel,
    required this.attendanceDate,
    required this.selectedBranch,
  });
  @override
  State<FilteringAttendanceWidget> createState() =>
      _FilteringAttendanceWidgetState();
}
class _FilteringAttendanceWidgetState extends State<FilteringAttendanceWidget> {
  List<BranchResponseModel> branchList = [];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //! Date picker
        ValueListenableBuilder(
          valueListenable: widget.attendanceDate,
          builder: (context, value, child) {
            return InkWell(
              onTap: () async {
                await pickAdaptiveDate(
                  context: context,
                  notifier: widget.attendanceDate,
                  initialDate: value,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime.now(),
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


        //! Select Branch
        BlocBuilder<BranchBloc, BranchState>(
          builder: (context, state) {
            if (state is GetBranchListSuccess) {
              branchList = state.branchResponseModel;
              if (branchList.isNotEmpty) {
                widget.selectedBranch.value = branchList.first;
              }
            }
            return InkWell(
              onTap: () async {
                if (branchList.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("কোন শাখা পাওয়া যায়নি")),
                  );
                  return;
                }
                final selected =
                    await showSelectionBottomSheetList<BranchResponseModel>(
                      context: context,
                      items: branchList,
                      itemLabel: (item) => item.name ?? "",
                    );
                if (selected != null) {
                  widget.selectedBranch.value = selected;
                } else {
                  widget.selectedBranch.value = branchList.first;
                }
              },
              child: _buildBox(
                child: ValueListenableBuilder<BranchResponseModel?>(
                  valueListenable: widget.selectedBranch,
                  builder: (context, value, child) {
                    return Text(
                      value?.name ?? "",
                      style: AppTextStyles.normalLight(
                        context,
                      ).copyWith(fontSize: 14),
                    );
                  },
                ),
              ),
            );
          },
        ),

        //! Filter Button
        InkWell(
          onTap: () {
            context.read<TeacherAttendanceBloc>().add(
              GetStudentListEvent(
                id: widget.attendanceModel.batchId,
                subjectId: widget.attendanceModel.subjectId,
                branchId: widget.selectedBranch.value?.id,
                date: DateFormat(
                  "yyyy-MM-dd",
                ).format(widget.attendanceDate.value),
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

  Widget _buildBox({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.arrow_drop_down, size: 20, color: Colors.black),
          const SizedBox(width: 4),
          child,
        ],
      ),
    );
  }
}
