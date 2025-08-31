import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_bar.dart';

class NotificationTeacherPage extends StatelessWidget {
  const NotificationTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Center(
        child: Text(
          "Notification",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
