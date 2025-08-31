import 'package:bloc/bloc.dart';
import '../../data/model/current_semester_list_model.dart';
import '../../data/service/current_semester_service.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CurrentSemesterService currentSemesterService = CurrentSemesterService();
  AttendanceBloc() : super(AttendanceInitial()) {
    on<FetchCurrentSemesterList>(_handleCurrentSemesterList);
  }

 Future<void> _handleCurrentSemesterList(FetchCurrentSemesterList event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final semesters = await currentSemesterService.getCurrentSemester();
      semesters.fold(
        (failure) => emit(AttendanceError(failure.message)),
        (semesterList) => emit(CurrentSemesterListLoaded(semesterList)),
      );
    } catch (e) {
      emit(AttendanceError(e.toString()));
    }
  }



}
