import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../../../core/constants/app_exception_messages.dart';
import '../../../../../core/model/send_file_model.dart';
import '../../data/data_sources/student_profile_data_source.dart';
import '../../data/model/student_profile_response_model.dart';
import '../../data/model/student_profile_update_request_model.dart';

part 'student_profile_event.dart';
part 'student_profile_state.dart';

class StudentProfileBloc extends Bloc<StudentProfileEvent, StudentProfileState> {
  StudentProfileBloc() : super(StudentProfileInitial()) {
    on<GetStudentProfileEvent>(_getStudentProfile);
    on<UpdateStudentProfileEvent>(_updateStudentProfile);
  }

  Future<void> _getStudentProfile(
    GetStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(StudentProfileLoading());
    try {
      final result = await StudentProfileDataSource.getStudentProfile();
      result.fold((ifLeft) => emit(StudentProfileError(ifLeft.message)), (
        ifRight,
      ) {
        emit(StudentProfileSuccess(ifRight));
      });
    } catch (e, stackTrace) {
      emit(StudentProfileError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }

  Future<void> _updateStudentProfile(
    UpdateStudentProfileEvent event,
    Emitter<StudentProfileState> emit,
  ) async {
    emit(StudentProfileUpdateLoading());
    try {
      final result = await StudentProfileDataSource.updateStudentProfile(
        payload: event.payload,
        files: event.files,
      );
      result.fold((ifLeft) => emit(StudentProfileUpdateError(ifLeft.message)), (
        ifRight,
      ) {
        emit(StudentProfileUpdateSuccess());
      });
    } catch (e, stackTrace) {
      emit(StudentProfileUpdateError(AppExceptionMessage.serverDefault));
      if (kDebugMode) {
        print("error: $e \n stackTrace: $stackTrace");
      }
    }
  }
}
