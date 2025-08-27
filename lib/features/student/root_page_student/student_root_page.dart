import 'package:flutter/material.dart';
import 'package:school_management/features/teacher/dashboard/presentation/pages/teacher_dashboard_page.dart';

import '../../../../../core/widgets/app_bottom_nav_bar.dart';

class StudentRootPage extends StatefulWidget {
  const StudentRootPage({super.key});

  @override
  State<StudentRootPage> createState() => _StudentRootPageState();
}

class _StudentRootPageState extends State<StudentRootPage> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> pageIndex = ValueNotifier<int>(0);

  final List<Widget> pages = [
    TeacherDashboardPage(),
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
