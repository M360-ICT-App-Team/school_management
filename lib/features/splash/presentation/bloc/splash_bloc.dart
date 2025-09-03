import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/local_database/auth_db.dart';
import '../../../app_version_check/data/data_source/app_version_data_source.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  String updateUrl = '';
  SplashBloc() : super(SplashInitial()) {
    on<GoRouteEvent>(_goRoute);
    on<CheckVersionEvent>(onCheckVersionEvent);
    on<UpdateAppEvent>(onUpdateAppEvent);
  }

  void _goRoute(GoRouteEvent event, Emitter<SplashState> emit) async {
    final role = await AuthLocalDB.getRole();

    if (role == null) {
      emit(RouteRoleSelectionState());
      return;
    }
    final token = await AuthLocalDB.getToken();

    if (role == AuthLocalDB.teacher) {
      if (token == null) {
        emit(RouteRoleSelectionState());
      } else {
        // emit(RouteHiringManagerRootState());
        //for user status get and check for route
        final accountStatus = await AuthLocalDB().getAccountStatus();
        if (accountStatus?.toLowerCase() == "active") {
          emit(RouteTeacherRootState());
        } else {
          emit(RouteTeacherLoginState());
        }
      }

      return;
    }

      else if (role == AuthLocalDB.student) {
      if (token == null) {
        emit(RouteRoleSelectionState());
      } else {
       
        final accountStatus = await AuthLocalDB().getAccountStatus();
        if (accountStatus?.toLowerCase() == "active") {
          emit(RouteStudentRootState());
        } else {
          emit(RouteStudentLoginState());
        }
      }

      return;
    }

    
  }
  FutureOr<void> onCheckVersionEvent(CheckVersionEvent event, Emitter<SplashState> emit) async {
    try {
      final res = await AppVersionDataSource.fetchAppVersion();
      res.fold((failed){
        emit(NoUpdateState());
      }, (data){
        final String? currentVersion = Platform.isAndroid ?  dotenv.env['ANDROID_VERSION'] : dotenv.env['IOS_VERSION'];
        if(data.isPause??false){
          emit(AppMaintenanceState(message: "App is under maintenance. Please try again later."));
        }else if(Platform.isAndroid){
          if(currentVersion != data.playStoreVersion){
            updateUrl = data.playStoreLink??"";
            emit(UpdateAvailableState(forceUpdate: data.forceUpdate??false, message: "Update Available. Please update the app to experience the latest features."));
          }else{
            emit(NoUpdateState());
          }
        }else if(Platform.isIOS){
          updateUrl = data.appStoreLink??"";
          if(currentVersion != data.appStoreVersion){
            emit(UpdateAvailableState(forceUpdate: data.forceUpdate??false, message: "Update Available. Please update the app to experience the latest features."));
          }else{
            emit(NoUpdateState());
          }
        }
      });
    } catch (e) {
      emit(NoUpdateState());
    }
  }

  FutureOr<void> onUpdateAppEvent(UpdateAppEvent event, Emitter<SplashState> emit) async {
    try {
      //? launch the update url (app store or play store)
      await launchUrl(Uri.parse(updateUrl));
    } catch (e, stackTrace) {
      log("",error: e, stackTrace: stackTrace);
      emit(NoUpdateState());
    }
  }




}
