import 'package:flutter/material.dart';
import 'package:school_management/core/widgets/app_bar.dart';

class NewAttendanceCreatePage extends StatefulWidget {
  const NewAttendanceCreatePage({super.key});

  @override
  State<NewAttendanceCreatePage> createState() => _NewAttendanceCreatePageState();
}

class _NewAttendanceCreatePageState extends State<NewAttendanceCreatePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
      appBar: CustomAppBar(),
    );
  }
}