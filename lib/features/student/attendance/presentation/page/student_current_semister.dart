import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../bloc/attendance_bloc.dart';
import '../widget/SemesterPagerCard.dart';

class StudentCurrentSemester extends StatefulWidget {
  const StudentCurrentSemester({super.key});

  @override
  State<StudentCurrentSemester> createState() => _StudentCurrentSemesterState();
}
class _StudentCurrentSemesterState extends State<StudentCurrentSemester> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AttendanceBloc>().add(FetchCurrentSemesterList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBack: false,),
      body: SafeArea(
          child: Column(
            children: [
              BlocConsumer<AttendanceBloc, AttendanceState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is AttendanceLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AttendanceError) {
                    return Center(child: Text(state.message));
                  } else if (state is CurrentSemesterListLoaded) {
                    final items = state.currentSemesterList;
                    if (items.isEmpty) {
                      return const Center(child: Text('No semesters available'));
                    }
                    return SemesterPagerCard(items: items);
                  }
                  return const SizedBox();
                },
              )
            ],
          )
      ),
    );
  }
}

