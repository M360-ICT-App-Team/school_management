import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../../../../core/local_database/auth_db.dart';
import '../../data/data_sources/teacher_auth_remote_data_source.dart';
import '../../data/model/teacher_login_request_model.dart';

part 'teacher_auth_event.dart';
part 'teacher_auth_state.dart';

class TeacherAuthBloc extends Bloc<TeacherAuthEvent, TeacherAuthState> {
  TeacherAuthBloc() : super(TeacherAuthInitial()) {
    on<TeacherLoginEvent>(_loginTeacher);
  }
    Future<void> _loginTeacher(TeacherLoginEvent event, Emitter<TeacherAuthState> emit) async {
    emit(TeacherLoginLoading());
    try {
      final result = await TeacherAuthRemoteDataSource.login(
        payload: event.teacherLoginRequestModel,
      );
      result.fold(
        (ifLeft) => emit(TeacherLoginError( ifLeft.message)),
        (ifRight) {
          emit(TeacherLoginSuccess());
                    AuthLocalDB().setAccountStatus(ifRight.status ?? '');

        },
      );
    } catch (e, stackTrace) {
      emit(TeacherLoginError( AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

}
