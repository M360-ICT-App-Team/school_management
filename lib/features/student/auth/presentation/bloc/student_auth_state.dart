part of 'student_auth_bloc.dart';

@immutable
sealed class StudentAuthState {}

final class StudentAuthInitial extends StudentAuthState {}

//!for login
final class StudentLoginLoading extends StudentAuthState {}

final class StudentLoginSuccess extends StudentAuthState {}

final class StudentLoginError extends StudentAuthState {
  final String message;
  StudentLoginError(this.message);
}
