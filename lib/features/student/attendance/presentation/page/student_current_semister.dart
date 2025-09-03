import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/widgets/app_empty.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../bloc/attendance_bloc.dart';
import '../widget/filter_button_student_widget.dart';
import '../widget/semester_pager_card_widget.dart';
import '../widget/student_attendance_list_widget.dart';

class StudentCurrentSemester extends StatefulWidget {
  const StudentCurrentSemester({super.key});

  @override
  State<StudentCurrentSemester> createState() => _StudentCurrentSemesterState();
}

class _StudentCurrentSemesterState extends State<StudentCurrentSemester> {
  final ValueNotifier<DateTime> attendanceDate = ValueNotifier(DateTime.now());
  final ValueNotifier<bool> expand = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(FetchCurrentSemesterList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<AttendanceBloc, AttendanceState>(
              buildWhen: (prev, curr) =>
                  curr is AttendanceLoading ||
                  curr is AttendanceError ||
                  curr is CurrentSemesterListLoaded,
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is AttendanceError) {
                  return Center(child: AppEmpty(msg: state.message));
                } else if (state is CurrentSemesterListLoaded) {
                  final items = state.currentSemesterList;
                  if (items.isEmpty) {
                    return Expanded(child: AppEmpty(msg: 'No data found'));
                  }
                  return Column(
                    children: [
                      SemesterPagerCard(items: items, expand: expand,),
                      FilterStudentAttendanceWidget(
                        attendanceDate: attendanceDate,
                        expand: expand,
                      ),
                    ],
                  );
                }
                return Expanded(child: AppEmpty(msg: 'No data found'));
              },
            ),
            SizedBox(height: 10),
            ValueListenableBuilder<bool>(
              valueListenable: expand, // 👈 use your notifier
              builder: (BuildContext context, bool isExpanded, Widget? child) {
                if (!isExpanded) {
                  return const SizedBox.shrink();
                }
                // When expanded = true → show the child (BlocBuilder)
                return child!;
              },
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  if (state is SingleSemesterLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (state is SingleSemesterError) {
                    return Center(child: AppEmpty(msg: state.message));
                  } else if (state is SingleSemesterListLoaded) {
                    final semesterList = state.singleSemesterList;
                    return StudentAttendanceListWidget(
                      singleSemesterData: semesterList,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
