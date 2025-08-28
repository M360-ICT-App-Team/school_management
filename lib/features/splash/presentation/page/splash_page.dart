import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/route/app_routes.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/app_adaptive_alert_dialog.dart';
import '../../../teacher/profile/presentation/bloc/teacher_profile_bloc.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _navigateToNextPage(SplashState state) {
      debugPrint("object state: $state");
      if (!mounted) return;
      debugPrint("-" * 50);

      if (state is RouteRoleSelectionState) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage, (p) => false);
      } else if (state is RouteTeacherLoginState) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.teacherLoginPage, (p) => false);
      } else if (state is RouteTeacherRootState) {
        context.read<TeacherProfileBloc>().add(GetTeacherProfileEvent());
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.teacherRootPage, (p) => false);
      } 
      else if(state is RouteStudentLoginState) {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.studentLoginPage, (p) => false);
      }
      else if (state is RouteStudentRootState) {
        // context.read<TeacherProfileBloc>().add(GetTeacherProfileEvent());
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.studentRootPage, (p) => false);
      }
      
      else {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.roleSelectionPage, (p) => false);
      }
  }

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(CheckVersionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      // listenWhen: (previous, current) => current is UpdateAvailableState || current is AppMaintenanceState || current is NoUpdateState,
      listener: (context, state) {
        if (state is UpdateAvailableState){
          appAdaptiveDialog(context: context, title: 'New Version Available', message: state.message, actions: [
            if(!state.forceUpdate) AdaptiveDialogAction(text: "Later", onPressed: () {
              Navigator.pop(context);
              //handleIntroNavigation();
              context.read<SplashBloc>().add(GoRouteEvent());
            }),
            AdaptiveDialogAction(text: "Update", onPressed: () {
              context.read<SplashBloc>().add(UpdateAppEvent());
            }, isDefault: true),
          ]);
        }else if(state is AppMaintenanceState){
          appAdaptiveDialog(context: context, title: 'App Maintenance', message: state.message, actions: [
            AdaptiveDialogAction(text: "Ok", onPressed: () {
              //? close app
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0); // Forcefully kills the process
              }
            }, isDefault: true),
          ]);
        }else if(state is NoUpdateState){
          context.read<SplashBloc>().add(GoRouteEvent());
        }else{
          _navigateToNextPage(state);
        }
      },
      child: Scaffold(body: Center(child: Image.asset(AppImages.logo))),
    );
  }
}
