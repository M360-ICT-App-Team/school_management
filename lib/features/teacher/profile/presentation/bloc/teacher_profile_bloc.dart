import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../data/data_sources/teacher_profile_data_source.dart';
import '../../data/model/teacher_profile_response_model.dart';
import '../../data/model/teacher_profile_update_request_model.dart';

part 'teacher_profile_event.dart';
part 'teacher_profile_state.dart';

class TeacherProfileBloc
    extends Bloc<TeacherProfileEvent, TeacherProfileState> {
  TeacherProfileBloc() : super(TeacherProfileInitial()) {
    on<GetTeacherProfileEvent>(_getTeacherProfile);
    on<UpdateTeacherProfileEvent>(_updateTeacherProfile);
  }

  Future<void> _getTeacherProfile(
    GetTeacherProfileEvent event,
    Emitter<TeacherProfileState> emit,
  ) async {
    emit(TeacherProfileLoading());
    try {
      final result = await TeacherProfileDataSource.getTeacherProfile();
      result.fold((ifLeft) => emit(TeacherProfileError(ifLeft.message)), (
        ifRight,
      ) {
        emit(TeacherProfileSuccess(ifRight));
      });
    } catch (e, stackTrace) {
      emit(TeacherProfileError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

  Future<void> _updateTeacherProfile(
    UpdateTeacherProfileEvent event,
    Emitter<TeacherProfileState> emit,
  ) async {
    emit(TeacherProfileUpdateLoading());
    try {
      final result = await TeacherProfileDataSource.updateTeacherProfile(
        payload: event.payload,
        files: event.files,
      );
      result.fold((ifLeft) => emit(TeacherProfileUpdateError(ifLeft.message)), (
        ifRight,
      ) {
        emit(TeacherProfileUpdateSuccess());
      });
    } catch (e, stackTrace) {
      emit(TeacherProfileUpdateError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }
}
