import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../data/data_sources/subject_remote_data_source.dart';
import '../../data/model/subject_list_response_teacher_model.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  SubjectBloc() : super(SubjectInitial()) {
    on<GetSubjectEvent>(_getSubject);
  }
    Future<void> _getSubject(
    GetSubjectEvent event,
    Emitter<SubjectState> emit,
  ) async {
    emit(GetSubjectLoading());
    try {
      final result =
          await SubjectRemoteDataSource.getSubject();
      result.fold(
        (ifLeft) => emit(GetSubjectError(ifLeft.message)),
        (ifRight) {
          emit(GetSubjectSuccess(ifRight));
        },
      );
    } catch (e, stackTrace) {
      emit(GetSubjectError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

}
