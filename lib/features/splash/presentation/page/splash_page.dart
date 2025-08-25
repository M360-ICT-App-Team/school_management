import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/route/app_routes.dart';
import '../../../../core/constants/app_images.dart';
import '../../../teacher/profile/presentation/bloc/teacher_profile_bloc.dart';
import '../bloc/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _navigateToNextPage(SplashState state) {
    Future.delayed(const Duration(milliseconds: 5400), () async {
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
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(GoRouteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        _navigateToNextPage(state);
      },
      child: Scaffold(body: Center(child: Image.asset(AppImages.logo))),
    );
  }
}
