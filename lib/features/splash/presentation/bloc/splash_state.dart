part of 'splash_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}


final class RouteRoleSelectionState extends SplashState {}
final class RouteTeacherLoginState extends SplashState {}
final class RouteTeacherRootState extends SplashState {}
