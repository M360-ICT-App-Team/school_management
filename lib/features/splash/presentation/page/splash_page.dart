import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/route/app_routes.dart';
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
        // context.read<ProfileJobSeekerBloc>().add(GetProfileJobSeekerEvent());
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(AppRoutes.teacherRootPage, (p) => false);
      } else {
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
      child: Scaffold(
        body: Center(child: Image.asset("assets/images/logo (2).png")),
      ),
    );
  }
}
