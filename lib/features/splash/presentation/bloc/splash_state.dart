part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

//!------for teacher ------
final class RouteRoleSelectionState extends SplashState {}
final class RouteTeacherLoginState extends SplashState {}
final class RouteTeacherRootState extends SplashState {}

//!------for student ------
final class RouteStudentLoginState extends SplashState {}
final class RouteStudentRootState extends SplashState {}
