import 'package:flutter/material.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../attendance/presentation/page/student_current_semister.dart';

class StudentMenuWidget extends StatefulWidget {
  const StudentMenuWidget({super.key});

  @override
  State<StudentMenuWidget> createState() => _StudentMenuWidgetState();
}

class _StudentMenuWidgetState extends State<StudentMenuWidget> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": AppImages.attendance,
      "title": "হাজিরা",
      "page": AppRoutes.studentCurrentSemester,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: menuItems.map((item) {
            return InkWell(
              onTap: () {
                if (item["page"] != null) {
                  Navigator.push(
                    context,
                   // MaterialPageRoute(builder: (context) => item["page"]),
                    MaterialPageRoute(builder: (context) => StudentCurrentSemester()),
                  );
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("Coming Soon")));
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(item["icon"]!, height: 50, width: 50),
                    const SizedBox(height: 6),
                    Text(
                      item["title"]!,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.normalLight(
                        context,
                      ).copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
