import 'package:flutter/material.dart';

import 'route/app_router.dart';
import 'route/app_routes.dart';
import 'theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School Management',
      theme: lightTheme,
      //  initialRoute: AppRoutes.splashPage,
      initialRoute: AppRoutes.roleSelectionPage,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
