part of 'teacher_auth_bloc.dart';

@immutable
sealed class TeacherAuthState {}

final class TeacherAuthInitial extends TeacherAuthState {}

//!for login
final class TeacherLoginLoading extends TeacherAuthState {}

final class TeacherLoginSuccess extends TeacherAuthState {}

final class TeacherLoginError extends TeacherAuthState {
  final String message;
  TeacherLoginError(this.message);
}