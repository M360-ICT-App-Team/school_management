import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/widgets/app_empty.dart';
import 'package:school_management/features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';

import '../../../../../core/widgets/app_bar.dart';
import '../widgets/select_batch_teacher_card_widget.dart';

class SelectBatchTeacherPage extends StatefulWidget {
  const SelectBatchTeacherPage({super.key});

  @override
  State<SelectBatchTeacherPage> createState() => _SelectBatchTeacherPageState();
}

class _SelectBatchTeacherPageState extends State<SelectBatchTeacherPage> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherAttendanceBloc>().add(GetTeacherBatchOverViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
        buildWhen: (previous, current) =>
            current is GetTeacherBatchOverViewLoading ||
            current is GetTeacherBatchOverViewSuccess ||
            current is GetTeacherBatchOverViewError,

        builder: (context, state) {
          if (state is GetTeacherBatchOverViewLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is GetTeacherBatchOverViewError) {
            return Center(child: AppEmpty(msg: state.message));
          } else if (state is GetTeacherBatchOverViewSuccess) {
            if (state.batchOverViewTeacherResponseModel.isEmpty) {
              return Center(child: AppEmpty(msg: "No batch found"));
            }
            return ListView.builder(
              itemCount: state.batchOverViewTeacherResponseModel.length,
              itemBuilder: (context, index) {
                final batch = state.batchOverViewTeacherResponseModel[index];
                return SelectBatchTeacherCardWidget(
                  batchOverViewTeacherResponseModel: batch,
                );
              },
            );
          } else {
            return Center(child: AppEmpty(msg: "Something went wrong"));
          }
        },
      ),
    );
  }
}
