import 'package:flutter/material.dart';
import 'package:school_management/features/teacher/attendance/presentation/pages/attendance_teacher_page.dart';

import '../../../../../core/constants/app_text_styles.dart';

class TeacherMenuWidget extends StatefulWidget {
  const TeacherMenuWidget({super.key});

  @override
  State<TeacherMenuWidget> createState() => _TeacherMenuWidgetState();
}

class _TeacherMenuWidgetState extends State<TeacherMenuWidget> {
    final List<Map<String, dynamic>> menuItems = [
  {"icon": "assets/images/attendance .png", "title": "হাজিরা", "page": AttendanceTeacherPage()},
    {"icon": "assets/images/payment.png", "title": "বেতন", "page": null},
    {"icon": "assets/images/notice.png", "title": "বিজ্ঞপ্তি", "page": null},
    {"icon": "assets/images/schedule.png", "title": "কেলেন্ডার", "page": null},
    {"icon": "assets/images/diary.png", "title": "ডাইরি", "page": null},
    {"icon": "assets/images/program.png", "title": "ক্লাস রুটিন", "page": null},
    {"icon": "assets/images/summer-holidays.png", "title": "মাসিক ছুটি", "page": null},
    {"icon": "assets/images/report-card.png", "title": "রেজাল্ট", "page": null},
    {"icon": "assets/images/ex_student.png", "title": "শিক্ষার্থী", "page": null},
  ];
  @override
  Widget build(BuildContext context) {
    return      Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: menuItems.map((item) {
                    return InkWell(
                      onTap: () {
                        // TODO: Navigate to respective page

                        if (item["page"] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item["page"],
                            ),
                          );
                        }
                        else{ 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Coming Soon")),
                          );
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