part of 'attendance_bloc.dart';

sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}
final class AttendanceLoading extends AttendanceState {}
final class AttendanceError extends AttendanceState {
  final String message;
  AttendanceError(this.message);
}
final class CurrentSemesterListLoaded extends AttendanceState {
  final List<CurrentSemesterListModel> currentSemesterList;
  CurrentSemesterListLoaded(this.currentSemesterList);
}
