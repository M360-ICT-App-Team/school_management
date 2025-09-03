import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:school_management/features/teacher/attendance/data/data_sources/teacher_attendance_remote_data_source.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../data/model/batch_over_view_teacher_response_model.dart';
import '../../data/model/student_list_response_teacher_model.dart';

part 'teacher_attendance_event.dart';
part 'teacher_attendance_state.dart';

class TeacherAttendanceBloc
    extends Bloc<TeacherAttendanceEvent, TeacherAttendanceState> {
  TeacherAttendanceBloc() : super(TeacherAttendanceInitial()) {
    on<GetTeacherBatchOverViewEvent>(_getTeacherBatchOverView);
    on<GetStudentListEvent>(_getStudentList);
    on<CreateAttendanceTeacherEvent>(_createAttendance);
    on<UpdateAttendanceTeacherEvent>(_updateAttendance);
  }
  Future<void> _getTeacherBatchOverView(
    GetTeacherBatchOverViewEvent event,
    Emitter<TeacherAttendanceState> emit,
  ) async {
    emit(GetTeacherBatchOverViewLoading());
    try {
      final result =
          await TeacherAttendanceRemoteDataSource.getTeacherBatchOverView( 
            subjectId: event.subjectId,
            dateRange: event.selectedDateRange,
          );
      result.fold(
        (ifLeft) => emit(GetTeacherBatchOverViewError(ifLeft.message)),
        (ifRight) {
          emit(GetTeacherBatchOverViewSuccess(ifRight));
        },
      );
    } catch (e, stackTrace) {
      emit(GetTeacherBatchOverViewError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

  Future<void> _getStudentList(
    GetStudentListEvent event,
    Emitter<TeacherAttendanceState> emit,
  ) async {
    emit(GetStudentListLoading());
    try {
      final result = await TeacherAttendanceRemoteDataSource.getStudentList(
        id: event.id,
        date: event.date,
        subjectId: event.subjectId,
        branchId: event.branchId,
      );
      result.fold((ifLeft) => emit(GetStudentListError(ifLeft.message)), (
        ifRight,
      ) {
        emit(GetStudentListSuccess(ifRight));
      });
    } catch (e, stackTrace) {
      emit(GetTeacherBatchOverViewError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

  Future<void> _createAttendance(
    CreateAttendanceTeacherEvent event,
    Emitter<TeacherAttendanceState> emit,
  ) async {
    emit(CreateAttendanceTeacherLoading());
    try {
      final result = await TeacherAttendanceRemoteDataSource.createAttendance(
        studentList: event.attendanceListModel,
        subjectOfferingId: event.subjectOfferingId,
        date: event.date,
        batchSemesterId: event.batchSemesterId,
        branchId: event.branchId,
      );
      result.fold(
        (ifLeft) => emit(CreateAttendanceTeacherError(ifLeft.message)),
        (ifRight) {
          emit(CreateAttendanceTeacherSuccess());
        },
      );
    } catch (e, stackTrace) {
      emit(CreateAttendanceTeacherError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

  Future<void> _updateAttendance(
    UpdateAttendanceTeacherEvent event,
    Emitter<TeacherAttendanceState> emit,
  ) async {
    emit(UpdateAttendanceTeacherLoading());
    try {
      final result = await TeacherAttendanceRemoteDataSource.updateAttendance(
        id: event.attendanceId,
        status: event.status,
      );
      result.fold(
        (ifLeft) => emit(UpdateAttendanceTeacherError(ifLeft.message)),
        (ifRight) {
          emit(UpdateAttendanceTeacherSuccess());
        },
      );
    } catch (e, stackTrace) {
      emit(UpdateAttendanceTeacherError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }
}
