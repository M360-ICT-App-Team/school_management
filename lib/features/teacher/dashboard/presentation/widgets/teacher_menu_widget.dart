import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_management/core/constants/app_images.dart';

import '../../../../../core/constants/app_text_styles.dart';
import '../../../attendance/presentation/pages/select_batch_teacher_page.dart';

class TeacherMenuWidget extends StatefulWidget {
  const TeacherMenuWidget({super.key});

  @override
  State<TeacherMenuWidget> createState() => _TeacherMenuWidgetState();
}

class _TeacherMenuWidgetState extends State<TeacherMenuWidget> {
  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": AppImages.attendance,
      "title": "হাজিরা",
      "page": SelectBatchTeacherPage(),
    },
    // {"icon": AppImages.payment, "title": "বেতন", "page": null},
    // {"icon": AppImages.notice, "title": "বিজ্ঞপ্তি", "page": null},
    // {"icon": AppImages.schedule, "title": "কেলেন্ডার", "page": null},
    // {"icon": AppImages.diary, "title": "ডাইরি", "page": null},
    // {"icon": AppImages.program, "title": "ক্লাস রুটিন", "page": null},
    // {"icon": AppImages.summerHolidays, "title": "মাসিক ছুটি", "page": null},
    // {"icon": AppImages.reportCard, "title": "রেজাল্ট", "page": null},
    // {"icon": AppImages.exStudent, "title": "শিক্ষার্থী", "page": null},
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
                    CupertinoPageRoute(builder: (context) => item["page"]),
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
