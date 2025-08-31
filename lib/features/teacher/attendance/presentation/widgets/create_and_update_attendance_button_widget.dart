import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/widgets/app_bottom_list.dart';
import 'package:school_management/features/teacher/attendance/data/model/student_list_response_teacher_model.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_bottom_list_sheet.dart';
import '../bloc/teacher_attendance_bloc.dart';

class CreateAndUpdateAttendanceButtonWidget extends StatefulWidget {
  final ValueNotifier<String?> selectedOption;
  final StudentListResponseTeacherModel studentListResponseTeacherModel;
  final AttendanceList student;
  const CreateAndUpdateAttendanceButtonWidget({
    super.key,
    required this.selectedOption,
    required this.studentListResponseTeacherModel,
    required this.student,
  });

  @override
  State<CreateAndUpdateAttendanceButtonWidget> createState() =>
      _CreateAndUpdateAttendanceButtonWidgetState();
}

class _CreateAndUpdateAttendanceButtonWidgetState
    extends State<CreateAndUpdateAttendanceButtonWidget> {
  final List<String> options = ["present", "late", "leave", "absent"];

  @override
  Widget build(BuildContext context) {
    final isSubmittedAttendance =
        widget.studentListResponseTeacherModel.isSubmitted;

    return isSubmittedAttendance == true
        ? Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () async {
                  final selected = await showSelectionBottomSheet<String>(
                    context: context,
                    builder: (ctx, onSelect) {
                      return ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          final branch = options[index];

                          return ListTile(
                            title: Text(
                              attendanceStatusFromString(branch).value,
                            ),
                            onTap: () => onSelect(branch),
                          );
                        },
                      );
                    },
                  );

                  if (selected != null) {
                    context.read<TeacherAttendanceBloc>().add(
                      UpdateAttendanceTeacherEvent(
                        attendanceId: widget.student.studentAttendanceId!,
                        status: selected,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.insidePadding - 2,
                    vertical: AppSizes.insidePadding - 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.blue, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
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
          )
        : InkWell(
            onTap: () async {
              final selected = await showSelectionBottomSheetList<String>(
                context: context,
                items: options,
                itemLabel: (item) => attendanceStatusFromString(item).value,
              );

              if (selected != null) {
                widget.student.status!.value = selected;
                widget.selectedOption.value = selected;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.insidePadding / 4,
              ),
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
                    valueListenable: widget.student.status!,
                    builder: (context, value, child) {
                      return Text(
                        attendanceStatusFromString(value).value,
                        style: AppTextStyles.normalLight(
                          context,
                        ).copyWith(fontSize: 14),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
