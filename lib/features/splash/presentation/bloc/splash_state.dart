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

//! -------for version--------
final class UpdateAvailableState extends SplashState {
  final bool forceUpdate;
  final String message;
  UpdateAvailableState({required this.forceUpdate, required this.message});
}

final class AppMaintenanceState extends SplashState {
  final String message;
  AppMaintenanceState({required this.message});
}

final class NoUpdateState extends SplashState {}
