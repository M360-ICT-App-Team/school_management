part of 'branch_bloc.dart';

@immutable
sealed class BranchState {}

final class BranchInitial extends BranchState {}


final class GetBranchListLoading extends BranchState {}

final class GetBranchListSuccess extends BranchState {
  final List<BranchResponseModel> branchResponseModel;
  GetBranchListSuccess(this.branchResponseModel);
}

final class GetBranchListError extends BranchState {
  final String message;
  GetBranchListError(this.message);
}