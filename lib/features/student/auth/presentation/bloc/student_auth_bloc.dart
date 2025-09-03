import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../data/data_sources/student_auth_remote_data_source.dart';
import '../../data/model/student_login_request_model.dart';

part 'student_auth_event.dart';
part 'student_auth_state.dart';

class StudentAuthBloc extends Bloc<StudentAuthEvent, StudentAuthState> {
  StudentAuthBloc() : super(StudentAuthInitial()) {
    on<StudentLoginEvent>(_studentLoginEvent);
  }

   Future<void> _studentLoginEvent(StudentLoginEvent event, Emitter<StudentAuthState> emit) async {
    emit(StudentLoginLoading());
    try {
      final result = await StudentAuthRemoteDataSource.loginStudent(
        payload: event.studentLoginRequestModel,
      );
      result.fold(
        (ifLeft) => emit(StudentLoginError( ifLeft.message)),
        (ifRight) {
          emit(StudentLoginSuccess());
          AuthLocalDB().setAccountStatus(ifRight.status ?? '');

        },
      );
    } catch (e, stackTrace) {
      emit(StudentLoginError( AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        debugPrint("error: $e \n stackTrace: $stackTrace");
      }
    }
  }
}
