part of 'student_auth_bloc.dart';

@immutable
sealed class StudentAuthEvent {}
//!for login 
class StudentLoginEvent extends StudentAuthEvent {
  final StudentLoginRequestModel studentLoginRequestModel;
  StudentLoginEvent({required this.studentLoginRequestModel});
}