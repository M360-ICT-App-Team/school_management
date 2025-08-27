part of 'student_profile_bloc.dart';

@immutable
sealed class StudentProfileState {}

final class StudentProfileInitial extends StudentProfileState {}


final class StudentProfileLoading extends StudentProfileState {}

final class StudentProfileSuccess extends StudentProfileState { 
  final StudentProfileResponseModel studentProfileResponseModel;
  StudentProfileSuccess(this.studentProfileResponseModel);
}

final class StudentProfileError extends StudentProfileState { 
  final String message;
  StudentProfileError(this.message);
}

//!for profile update

final class StudentProfileUpdateLoading extends StudentProfileState {}

final class StudentProfileUpdateSuccess extends StudentProfileState {
}

final class StudentProfileUpdateError extends StudentProfileState { 
  final String message;
  StudentProfileUpdateError(this.message);
}