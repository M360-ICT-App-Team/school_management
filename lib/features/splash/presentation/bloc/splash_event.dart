part of 'splash_bloc.dart';

@immutable
sealed class SplashEvent {}
class GoRouteEvent extends SplashEvent {}
class CheckVersionEvent extends SplashEvent {}

class UpdateAppEvent extends SplashEvent {}
