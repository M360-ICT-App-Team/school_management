part of 'teacher_attendance_bloc.dart';

@immutable
sealed class TeacherAttendanceState {}

final class TeacherAttendanceInitial extends TeacherAttendanceState {}


//!for get batch overview
final class GetTeacherBatchOverViewLoading extends TeacherAttendanceState {}

final class GetTeacherBatchOverViewSuccess extends TeacherAttendanceState { 
  final List<BatchOverViewTeacherResponseModel> batchOverViewTeacherResponseModel;
  GetTeacherBatchOverViewSuccess(this.batchOverViewTeacherResponseModel);

}

final class GetTeacherBatchOverViewError extends TeacherAttendanceState {
  final String message;
  GetTeacherBatchOverViewError(this.message);
}

//!for get student list
final class GetStudentListLoading extends TeacherAttendanceState {}

final class GetStudentListSuccess extends TeacherAttendanceState { 
  final List<StudentListResponseTeacherModel> studentListResponseTeacherModel;
  GetStudentListSuccess(this.studentListResponseTeacherModel);

}

final class GetStudentListError extends TeacherAttendanceState {
  final String message;
  GetStudentListError(this.message);
}