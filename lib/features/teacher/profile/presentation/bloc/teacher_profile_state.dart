part of 'teacher_profile_bloc.dart';

@immutable
sealed class TeacherProfileState {}

final class TeacherProfileInitial extends TeacherProfileState {}

final class TeacherProfileLoading extends TeacherProfileState {}

final class TeacherProfileSuccess extends TeacherProfileState { 
  final TeacherProfileResponseModel teacherProfileResponseModel;
  TeacherProfileSuccess(this.teacherProfileResponseModel);
}

final class TeacherProfileError extends TeacherProfileState { 
  final String message;
  TeacherProfileError(this.message);
}

//!for profile update

final class TeacherProfileUpdateLoading extends TeacherProfileState {}

final class TeacherProfileUpdateSuccess extends TeacherProfileState {
}

final class TeacherProfileUpdateError extends TeacherProfileState { 
  final String message;
  TeacherProfileUpdateError(this.message);
}

