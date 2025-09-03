import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:polytech/core/constants/app_icons.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_convert_date_time.dart';
import '../../../../../core/widgets/app_adaptive_date.dart';
import '../bloc/attendance_bloc.dart';

class FilterStudentAttendanceWidget extends StatefulWidget {

  final ValueNotifier<DateTime> attendanceDate;
  final ValueNotifier<bool> expand;
  const FilterStudentAttendanceWidget({
    super.key,

    required this.attendanceDate,
    required this.expand,
  });
  @override
  State<FilterStudentAttendanceWidget> createState() =>
      _FilterStudentAttendanceWidgetState();
}
class _FilterStudentAttendanceWidgetState extends State<FilterStudentAttendanceWidget> {
  @override

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if(!context.mounted) return;
                context.read<AttendanceBloc>().add(
                  FetchSingleSemesterList(
                      dateTime: DateFormat(
                        "yyyy-MM-dd",
                      ).format(widget.attendanceDate.value)
                  ),
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
        //! Filter Button
        ValueListenableBuilder(
          valueListenable: widget.expand,
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                widget.expand.value = !widget.expand.value; // 👈 toggle
                context.read<AttendanceBloc>().add(
                  FetchSingleSemesterList(
                    dateTime: DateFormat(
                      "yyyy-MM-dd",
                    ).format(widget.attendanceDate.value)
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
                  widget.expand.value?"সংক্ষিপ্ত":'বিস্তারিত',
                  style: AppTextStyles.normalBold(
                    context,
                  ).copyWith(fontSize: 16, color: AppColors.white),
                ),
              ),
            );
          }
        ),
    ]
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
          const Icon(AppIcons.arrowDown, size: 20, color: Colors.black),
          const SizedBox(width: 4),
          child,
        ],
      ),
    );
  }
}
