import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:school_management/features/teacher/branch/data/data_sources/branch_remote_data_source.dart';
import 'package:school_management/features/teacher/branch/data/model/branch_response_model.dart';

import '../../../../../core/constants/app_exception_messages.dart';

part 'branch_event.dart';
part 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  BranchBloc() : super(BranchInitial()) {
       on<GetBranchListEvent>(_getBranchList);

  }

      Future<void> _getBranchList(
    GetBranchListEvent event,
    Emitter<BranchState> emit,
  ) async {
    emit(GetBranchListLoading());
    try {
      final result =
          await BranchRemoteDataSource.getBranch();
      result.fold(
        (ifLeft) => emit(GetBranchListError(ifLeft.message)),
        (ifRight) {
          emit(GetBranchListSuccess(ifRight));
        },
      );
    } catch (e, stackTrace) {
      emit(GetBranchListError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }
}
