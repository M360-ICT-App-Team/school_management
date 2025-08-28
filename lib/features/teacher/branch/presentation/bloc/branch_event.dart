part of 'branch_bloc.dart';

@immutable
sealed class BranchEvent {}
class GetBranchListEvent extends BranchEvent {}
