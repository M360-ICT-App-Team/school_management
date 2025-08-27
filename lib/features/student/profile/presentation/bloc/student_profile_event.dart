part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileEvent {}


//!for get Student profile
class GetStudentProfileEvent extends StudentProfileEvent {}

//!for update Student profile
class UpdateStudentProfileEvent extends StudentProfileEvent { 
  final StudentProfileUpdateRequestModel payload;
  final List<SendFileModel> files;
  UpdateStudentProfileEvent({required this.payload, required this.files});
}