part of 'teacher_auth_bloc.dart';

@immutable
sealed class TeacherAuthEvent {}

//!for login 
class TeacherLoginEvent extends TeacherAuthEvent {
  final TeacherLoginRequestModel teacherLoginRequestModel;
  TeacherLoginEvent({required this.teacherLoginRequestModel});
}