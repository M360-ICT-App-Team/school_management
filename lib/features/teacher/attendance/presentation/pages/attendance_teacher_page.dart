import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/constants/app_text_styles.dart';
import 'package:school_management/core/widgets/app_bar.dart';

import '../../../../../app/route/app_routes.dart';

class AttendanceTeacherPage extends StatefulWidget {
  const AttendanceTeacherPage({super.key});

  @override
  State<AttendanceTeacherPage> createState() => _AttendanceTeacherPageState();
}

class _AttendanceTeacherPageState extends State<AttendanceTeacherPage> {
  final List<Map<String, String>> students = [
    {"name": "মোঃ নাফিজ ইসলাম", "id": "১২৪৫৬৮৪৮০০০১২", "status": "উপস্থিত"},
    {"name": "মোঃ নাফিজ ইসলাম", "id": "১২৪৫৬৮৪৮০০০১৩", "status": "উপস্থিত"},
    {"name": "মোঃ নাফিজ ইসলাম", "id": "১২৪৫৬৮৪৮০০০১৪", "status": "অনুপস্থিত"},
  ];
  Color getStatusColor(String status) {
    switch (status) {
      case "উপস্থিত":
        return Colors.green;
      case "অনুপস্থিত":
        return Colors.red;
      case "সিডিউল হযনি":
        return Colors.black87;
      case "ছুটি":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.insidePadding,
              vertical: AppSizes.insidePadding * 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "হাজিরা",
                  style: AppTextStyles.normalBold(context).copyWith(
                    fontSize: 22,
                    color: AppColors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.blue,
                  ),
                ),

                /// New Add Button
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSizes.bodyPadding / 2,
                    vertical: AppSizes.bodyPadding / 2,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.insidePadding * 5,
                    vertical: AppSizes.insidePadding,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.blue, width: 2),
                  ),
                  child: SizedBox(
                    width: 160,
                    height: 40,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.blue,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.newAttendanceCreatePage,
                        );
                      },
                      child: Text(
                        "নতুন যোগ করুন",
                        style: AppTextStyles.normalLight(
                          context,
                        ).copyWith(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),

                /// Date + Subject + Filter Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!date picker
                    InkWell(
                      onTap: () {
                        //showDateDialog(context);

                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(2018, 3, 5),
                          maxTime: DateTime(2019, 6, 7),
                          onChanged: (date) {
                            print('change $date');
                          },
                          onConfirm: (date) {
                            print('confirm $date');
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.bn,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffd9d9d9),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "১০-০৭-২০২৪",
                              style: AppTextStyles.normalLight(
                                context,
                              ).copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //! subject choice
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffd9d9d9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black, width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "সাবজেক্ট",
                            style: AppTextStyles.normalLight(
                              context,
                            ).copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    //! Filter Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "ফিল্টার",
                        style: AppTextStyles.normalBold(
                          context,
                        ).copyWith(fontSize: 16, color: AppColors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                //!for attendance list
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.blue, width: 2),
                  ),
                  child: Column(
                    children: [
                      //! Header Row
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.insidePadding,
                          vertical: AppSizes.insidePadding - 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.blue,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "আইডি",
                                  style: AppTextStyles.normalBold(
                                    context,
                                  ).copyWith(color: AppColors.blue),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "উপস্থিতি",
                                style: AppTextStyles.normalBold(
                                  context,
                                ).copyWith(color: AppColors.blue),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "একশন",
                                textAlign: TextAlign.end,
                                style: AppTextStyles.normalBold(
                                  context,
                                ).copyWith(color: AppColors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// Student Rows
                      ...students.map(
                        (student) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.insidePadding,
                            vertical: AppSizes.insidePadding,
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.blue.withAlpha(40),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //! Name + ID + Avatar
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: AppColors.blue,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            student["name"]!,
                                            style: AppTextStyles.normalLight(
                                              context,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            student["id"]!,
                                            style: AppTextStyles.normalLight(
                                              context,
                                            ).copyWith(fontSize: 12),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// Status
                              Expanded(
                                flex: 1,
                                child: Text(
                                  student["status"]!,
                                  style: AppTextStyles.normalBold(context)
                                      .copyWith(
                                        color: getStatusColor(
                                          student["status"]!,
                                        ),
                                        fontSize: 10,
                                      ),
                                ),
                              ),

                              /// Action Button
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.insidePadding - 2,
                                      vertical: AppSizes.insidePadding - 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColors.blue,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "পরিবর্তন",
                                      style: AppTextStyles.normalLight(
                                        context,
                                      ).copyWith(fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
