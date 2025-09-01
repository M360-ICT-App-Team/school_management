part of 'attendance_bloc.dart';


sealed class AttendanceEvent {}
final class FetchCurrentSemesterList extends AttendanceEvent {}
final class FetchSingleSemesterList extends AttendanceEvent{
  final String dateTime;
  FetchSingleSemesterList({required this.dateTime});
}








