import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/features/teacher/branch/presentation/bloc/branch_bloc.dart';
import 'package:school_management/features/teacher/profile/presentation/bloc/teacher_profile_bloc.dart';

import '../features/common/subject/presentation/bloc/subject_bloc.dart';
import '../features/splash/presentation/bloc/splash_bloc.dart';
import '../features/student/attendance/presentation/bloc/attendance_bloc.dart';
import '../features/student/auth/presentation/bloc/student_auth_bloc.dart';
import '../features/student/profile/presentation/bloc/student_profile_bloc.dart';
import '../features/teacher/attendance/presentation/bloc/teacher_attendance_bloc.dart';
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
         BlocProvider<SplashBloc>(create: (context) => SplashBloc()),
         //!-------for teacher--------
        BlocProvider<TeacherAuthBloc>(create: (context) => TeacherAuthBloc()), 
        BlocProvider<TeacherProfileBloc>(
          create: (context) => TeacherProfileBloc(),
        ),
      BlocProvider<TeacherAttendanceBloc>(create: (context) => TeacherAttendanceBloc()), 
      BlocProvider<SubjectBloc>(create: (context) => SubjectBloc()), 
            BlocProvider<BranchBloc>(create: (context) => BranchBloc()), 


        //!-------for student--------
         BlocProvider<StudentAuthBloc>(create: (context) => StudentAuthBloc()),
        BlocProvider<StudentProfileBloc>(create: (context) => StudentProfileBloc()),
        BlocProvider<AttendanceBloc>(create: (context) => AttendanceBloc()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Polytech',
        theme: lightTheme,
        //  initialRoute: AppRoutes.splashPage,
        initialRoute: AppRoutes.splashPage,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
