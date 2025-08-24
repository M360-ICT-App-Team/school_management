part of 'teacher_profile_bloc.dart';

@immutable
sealed class TeacherProfileEvent {}


//!for get teacher profile
class GetTeacherProfileEvent extends TeacherProfileEvent {}

//!for update teacher profile
class UpdateTeacherProfileEvent extends TeacherProfileEvent { 
  final TeacherProfileUpdateRequestModel payload;
  final List<SendFileModel> files;
  UpdateTeacherProfileEvent({required this.payload, required this.files});
}