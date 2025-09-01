import 'package:bloc/bloc.dart';
import '../../data/data_sources/current_semester_service.dart';
import '../../data/model/current_semester_list_model.dart';
import '../../data/model/student_single_semester_list_model.dart';


part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  CurrentSemesterService currentSemesterService = CurrentSemesterService();
  AttendanceBloc() : super(AttendanceInitial()) {
    on<FetchCurrentSemesterList>(_handleCurrentSemesterList);
    on<FetchSingleSemesterList>(_handleSingleSemesterList);
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
  Future<void> _handleSingleSemesterList(FetchSingleSemesterList event, Emitter<AttendanceState> emit) async {
    emit(SingleSemesterLoading());
    try {
      final semesters = await currentSemesterService.getSingleSemester(date: event.dateTime);
      semesters.fold(
            (failure) => emit(SingleSemesterError(failure.message)),
            (semesterList) => emit(SingleSemesterListLoaded(semesterList)),
      );
    } catch (e) {
      emit(SingleSemesterError(e.toString()));
    }
  }



}
