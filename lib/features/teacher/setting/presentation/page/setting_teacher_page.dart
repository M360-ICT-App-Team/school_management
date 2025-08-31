import 'package:flutter/material.dart';
import 'package:school_management/core/widgets/app_bar.dart';

class SettingTeacherPage extends StatelessWidget {
  const SettingTeacherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          "Setting",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
