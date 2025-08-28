import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/features/teacher/attendance/data/model/attendance_model.dart';

import '../../features/role_selection/presentation/pages/role_selection_page.dart';
import '../../features/splash/presentation/page/splash_page.dart';
import '../../features/student/auth/presentation/pages/student_login_page.dart';
import '../../features/student/profile/presentation/page/student_profile_update.dart';
import '../../features/student/root_page_student/student_root_page.dart';
import '../../features/teacher/attendance/presentation/pages/attendance_teacher_page.dart';
import '../../features/teacher/attendance/presentation/pages/new_attendance_create_page.dart';
import '../../features/teacher/auth/presentation/pages/teacher_login_page.dart';
import '../../features/teacher/dashboard/presentation/pages/teacher_dashboard_page.dart';
import '../../features/teacher/profile/presentation/pages/teacher_profile_page.dart';
import '../../features/teacher/profile/presentation/pages/teacher_profile_update_page.dart';
import '../../features/teacher/root_page_teacher/presentation/pages/teacher_root_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
          case AppRoutes.splashPage:
        return CupertinoPageRoute(builder: (_) => const SplashPage());
      case '/':
        return CupertinoPageRoute(builder: (_) => const Placeholder());
      //! Root


//!for teacher
      case AppRoutes.teacherRootPage:
        return CupertinoPageRoute(builder: (_) => const TeacherRootPage());

      case AppRoutes.teacherLoginPage:
        return CupertinoPageRoute(builder: (_) => const TeacherLoginPage());

      case AppRoutes.teacherDashboardPage:
        return CupertinoPageRoute(builder: (_) => const TeacherDashboardPage());

              case AppRoutes.roleSelectionPage:
        return CupertinoPageRoute(builder: (_) => const RoleSelectionPage());
                      case AppRoutes.attendanceTeacherPage:
        return CupertinoPageRoute(builder: (_) =>  AttendanceTeacherPage( 
          attendanceModel: settings.arguments as AttendanceModel,
        ));
         case AppRoutes.newAttendanceCreatePage:
        return CupertinoPageRoute(builder: (_) => const NewAttendanceCreatePage());
          case AppRoutes.teacherProfilePage:
        return CupertinoPageRoute(builder: (_) => const TeacherProfilePage());
          case AppRoutes.teacherProfileUpdatePage:
        return CupertinoPageRoute(builder: (_) => const TeacherProfileUpdatePage());
//!------------------end for teacher------------------


//!for student
case AppRoutes.studentRootPage:
        return CupertinoPageRoute(builder: (_) => const StudentRootPage());
   case AppRoutes.studentLoginPage:
        return CupertinoPageRoute(builder: (_) => const StudentLoginPage());
      default:
        return CupertinoPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
