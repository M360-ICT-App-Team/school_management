import 'package:flutter/material.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/constants/app_text_styles.dart';
import 'package:school_management/core/widgets/app_bar.dart';

import '../widgets/teacher_header_widget.dart';
import '../widgets/teacher_menu_widget.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f7f7),
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSizes.bodyPadding,
                vertical: AppSizes.bodyPadding,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.insidePadding * 2,
                vertical: AppSizes.insidePadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.blue, width: 2),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo (2).png",
                    height: 120,
                    width: 120,
                  ),
                  const Expanded(child: TeacherHeaderWidget()),
                ],
              ),
            ),
            Image.asset("assets/images/cyber_notice.png"),
            Divider(color: AppColors.lightGrey, thickness: 1),

            //! Menu without GridView
       TeacherMenuWidget(),
          ],
        ),
      ),
    );
  }
}
