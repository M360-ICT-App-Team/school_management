part of 'subject_bloc.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}


final class GetSubjectLoading extends SubjectState {}

final class GetSubjectSuccess extends SubjectState {
  final List<SubjectListResponseTeacherModel> subjectResponseModel;
  GetSubjectSuccess(this.subjectResponseModel);
}

final class GetSubjectError extends SubjectState {
  final String message;
  GetSubjectError(this.message);
}
