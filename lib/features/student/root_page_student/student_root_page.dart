import 'package:flutter/material.dart';

import '../../../../../core/widgets/app_bottom_nav_bar.dart';
import '../dashboard/presentation/pages/student_dashboard_page.dart';


class StudentRootPage extends StatefulWidget {
  const StudentRootPage({super.key});

  @override
  State<StudentRootPage> createState() => _StudentRootPageState();
}

class _StudentRootPageState extends State<StudentRootPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);

  final List<Widget> pages = [
   // TeacherDashboardPage(),
    StudentDashboardPage()
   // StudentProfilePage()
    // MyRequestPageHiring()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                pageIndex.value = index;
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: pageIndex,
            builder: (context, index, child) {
              return CustomBottomNavBar(
                currentIndex: index,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
