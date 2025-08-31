part of 'teacher_attendance_bloc.dart';

@immutable
sealed class TeacherAttendanceEvent {}


//!for get batch overview
class GetTeacherBatchOverViewEvent extends TeacherAttendanceEvent {}

//!for get student list
class GetStudentListEvent extends TeacherAttendanceEvent { 
  final int id;
  final String? date;
  final int ? subjectId;
   final int ? branchId;
  GetStudentListEvent({required this.id,required this.date,required this.subjectId , this.branchId});
}



//!for create attendance
class CreateAttendanceTeacherEvent extends TeacherAttendanceEvent { 
 final List<AttendanceList> attendanceListModel;
 final DateTime? date;
 final int? subjectOfferingId;
 final int? batchSemesterId;

  CreateAttendanceTeacherEvent({required this.attendanceListModel,required this.date,required this.subjectOfferingId,required this.batchSemesterId});
}

//!update attendance
class UpdateAttendanceTeacherEvent extends TeacherAttendanceEvent { 
final int attendanceId;
final String status;
  UpdateAttendanceTeacherEvent({required this.attendanceId,required this.status});
}