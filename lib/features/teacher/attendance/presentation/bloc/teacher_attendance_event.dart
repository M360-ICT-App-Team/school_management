part of 'teacher_attendance_bloc.dart';

@immutable
sealed class TeacherAttendanceEvent {}


//!for get batch overview
class GetTeacherBatchOverViewEvent extends TeacherAttendanceEvent {}

//!for get student list
class GetStudentListEvent extends TeacherAttendanceEvent { 
  final int id;
  final DateTime? date;
  final int subjectId;
  GetStudentListEvent({required this.id,required this.date,required this.subjectId});
}