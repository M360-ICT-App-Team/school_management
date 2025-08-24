import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_bar.dart';

class TeacherProfileUpdatePage extends StatefulWidget {
  const TeacherProfileUpdatePage({super.key});

  @override
  State<TeacherProfileUpdatePage> createState() =>
      _TeacherProfileUpdatePageState();
}

class _TeacherProfileUpdatePageState extends State<TeacherProfileUpdatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),

        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppSizes.insidePadding,
                vertical: AppSizes.insidePadding,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.insidePadding,
                vertical: AppSizes.insidePadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.blue, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(AppImages.logo,
                        height: 120,
                        width: 120,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(
                            AppSizes.insidePadding / 2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "রিফাত হাসান প্রিয়",
                                style: AppTextStyles.normalLight(
                                  context,
                                ).copyWith(fontSize: 12),
                              ),
                              Text(
                                "আইডি: ",
                                style: AppTextStyles.normalLight(
                                  context,
                                ).copyWith(fontSize: 12),
                              ),
                              Text(
                                "দায়িত্বপ্রাপ্ত বিভাগ: সিভিল ইঞ্জিনিয়ারিং",
                                style: AppTextStyles.normalLight(
                                  context,
                                ).copyWith(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),

                              Text(
                                "০১৭১১১১১১১১",
                                style: AppTextStyles.normalLight(
                                  context,
                                ).copyWith(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "shorifful@gmail.com",
                                    style: AppTextStyles.normalLight(
                                      context,
                                    ).copyWith(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.insidePadding),
                  profileInfoList(context, "ফোন নম্বর", "০১৭১১১১১১১১"),
                  profileInfoList(context, "ইমেইল", "shorifful@gmail.com"),
                  profileInfoList(context, "পিতার নাম", ""),
                  profileInfoList(context, "মাতার নাম", ""),
                  profileInfoList(
                    context,
                    "বর্তমান ঠিকানা",
                    "",
                    isMultiLine: true,
                  ),
                  profileInfoList(
                    context,
                    "স্থায়ী ঠিকানা",
                    "",
                    isMultiLine: true,
                  ),
                  profileInfoList(context, "রক্তের গ্রুপ", "O+"),
                ],
              ),
            ),
            SizedBox(
              width: 190,
              height: 40,
              child: FilledButton(
                style: FilledButton.styleFrom(backgroundColor: AppColors.blue),
                onPressed: () {},
                child: Text("নিশ্চিত করুন"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileInfoList(
    BuildContext context,
    String key,
    String value, {
    bool? isMultiLine = false,
  }) {
    final controller = TextEditingController(text: value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.insidePadding / 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              key,
              style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
            ),
          ),
          const Text(" : "),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: isMultiLine! ? 3 : 1,
              style: AppTextStyles.normalLight(context).copyWith(fontSize: 16),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
