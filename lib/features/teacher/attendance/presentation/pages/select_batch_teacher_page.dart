import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/widgets/app_empty.dart';
import 'package:school_management/features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/utilities/app_filtering_bottom_sheet.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../common/subject/data/model/subject_list_response_teacher_model.dart';
import '../../../../common/subject/presentation/bloc/subject_bloc.dart';
import '../widgets/select_batch_teacher_card_widget.dart';

class SelectBatchTeacherPage extends StatefulWidget {
  const SelectBatchTeacherPage({super.key});

  @override
  State<SelectBatchTeacherPage> createState() => _SelectBatchTeacherPageState();
}

class _SelectBatchTeacherPageState extends State<SelectBatchTeacherPage> {
  final ValueNotifier<SubjectListResponseTeacherModel?> selectedSubject =
      ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    context.read<TeacherAttendanceBloc>().add(GetTeacherBatchOverViewEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.insidePadding),
        child: Column(
          children: [
            //! for choosing subject
            SizedBox(
              width: 100,
              child: InkWell(
                onTap: () => pickSubject(context),
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

            const SizedBox(height: 10),

            //! for building batch list
            Expanded(
              child: BlocBuilder<TeacherAttendanceBloc, TeacherAttendanceState>(
                buildWhen: (previous, current) =>
                    current is GetTeacherBatchOverViewLoading ||
                    current is GetTeacherBatchOverViewSuccess ||
                    current is GetTeacherBatchOverViewError,
                builder: (context, state) => buildBatchList(state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> pickSubject(BuildContext context) async {
  //   context.read<SubjectBloc>().add(GetSubjectEvent());
  //   final selected =
  //       await showSelectionBottomSheet<SubjectListResponseTeacherModel>(
  //         context: context,
  //         builder: (ctx, onSelect) {
  //           return BlocBuilder<SubjectBloc, SubjectState>(
  //             builder: (context, state) {
  //               if (state is GetSubjectLoading) {
  //                 return const Center(
  //                   child: CircularProgressIndicator.adaptive(),
  //                 );
  //               } else if (state is GetSubjectSuccess) {
  //                 if (state.subjectResponseModel.isEmpty) {
  //                   return const Center(
  //                     child: Text("কোনো সাবজেক্ট পাওয়া যায়নি"),
  //                   );
  //                 }
  //                 return ListView.builder(
  //                   itemCount: state.subjectResponseModel.length,
  //                   itemBuilder: (context, index) {
  //                     final subject = state.subjectResponseModel[index];
  //                     return ListTile(
  //                       title: Text(subject.subjectName ?? "unknown"),
  //                       onTap: () => onSelect(subject),
  //                     );
  //                   },
  //                 );
  //               } else if (state is GetSubjectError) {
  //                 return const Center(child: Text("কোনো সাবজেক্ট পাওয়া যায়নি"));
  //               }
  //               return const SizedBox.shrink();
  //             },
  //           );
  //         },
  //       );

  //   if (selected != null) {
  //     selectedSubject.value = selected;
  //   }
  // }

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

  Widget buildBatchList(TeacherAttendanceState state) {
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
          );
        },
      );
    }
    return const Center(child: AppEmpty(msg: "Something went wrong"));
  }
}
