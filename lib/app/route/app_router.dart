import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../features/role_selection/presentation/pages/role_selection_page.dart';
import '../../features/teacher/attendance/presentation/pages/attendance_teacher_page.dart';
import '../../features/teacher/attendance/presentation/pages/new_attendance_create_page.dart';
import '../../features/teacher/auth/presentation/pages/teacher_login_page.dart';
import '../../features/teacher/dashboard/presentation/pages/teacher_dashboard_page.dart';
import '../../features/teacher/root_page/presentation/pages/teacher_root_page.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashPage:
      // return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/':
        return MaterialPageRoute(builder: (_) => const Placeholder());
      //! Root

      case AppRoutes.teacherRootPage:
        return MaterialPageRoute(builder: (_) => const TeacherRootPage());

      case AppRoutes.teacherLoginPage:
        return MaterialPageRoute(builder: (_) => const TeacherLoginPage());

      case AppRoutes.teacherDashboardPage:
        return MaterialPageRoute(builder: (_) => const TeacherDashboardPage());

              case AppRoutes.roleSelectionPage:
        return MaterialPageRoute(builder: (_) => const RoleSelectionPage());
                      case AppRoutes.attendanceTeacherPage:
        return MaterialPageRoute(builder: (_) => const AttendanceTeacherPage());
         case AppRoutes.newAttendanceCreatePage:
        return MaterialPageRoute(builder: (_) => const NewAttendanceCreatePage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
