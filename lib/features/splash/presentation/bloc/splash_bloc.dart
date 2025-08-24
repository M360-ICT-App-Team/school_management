import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_management/core/local_database/auth_db.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<GoRouteEvent>(_goRoute);

  }

    void _goRoute(GoRouteEvent event, Emitter<SplashState> emit) async {
    final role = await AuthLocalDB.getRole();

  if (role == null) {
      emit(RouteRoleSelectionState());
      return;
    }
    final token = await AuthLocalDB.getToken();

   if (role ==  AuthLocalDB.teacher) {
      if (token == null) {
        emit(RouteRoleSelectionState());
      } else {
        // emit(RouteHiringManagerRootState());
        //for user status get and check for route 
        final accountStatus = await AuthLocalDB().getAccountStatus();
        if (accountStatus?.toLowerCase() == "active") {
          emit(RouteTeacherRootState());
        } else {
          emit(RouteTeacherRootState());
        }
      }

       return;
    }

  }
}
