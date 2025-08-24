import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/features/teacher/profile/presentation/bloc/teacher_profile_bloc.dart';

import '../features/splash/presentation/bloc/splash_bloc.dart';
import '../features/teacher/auth/presentation/bloc/teacher_auth_bloc.dart';
import 'route/app_router.dart';
import 'route/app_routes.dart';
import 'theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TeacherAuthBloc>(create: (context) => TeacherAuthBloc()),
        BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
        BlocProvider<TeacherProfileBloc>(
          create: (context) => TeacherProfileBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Management',
        theme: lightTheme,
        //  initialRoute: AppRoutes.splashPage,
        initialRoute: AppRoutes.splashPage,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
