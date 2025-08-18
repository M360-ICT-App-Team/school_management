import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/widgets/app_bar.dart';
import 'package:school_management/core/widgets/app_input_widgets.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_footer.dart';

class TeacherLoginPage extends StatelessWidget {
  const TeacherLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.bodyPadding * 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "শিক্ষক",
                  style: AppTextStyles.normalLight(
                    context,
                  ).copyWith(fontSize: 24),
                ),
              ),
              SizedBox(
                width: 300,
                child: AppTextField(
                  hintText: "আইডি",
                  controller: controller,
                  prefixIcon: Icon(
                    HugeIcons.strokeRoundedId,
                    color: AppColors.primary.withAlpha(70),
                  ),
                ),
              ),

              SizedBox(
                width: 300,
                child: AppTextField(
                  hintText: "পিন",
                  controller: controller,
                  prefixIcon: Icon(
                    HugeIcons.strokeRoundedKey01,
                    color: AppColors.primary.withAlpha(70),
                  ),
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: 140,
                height: 40,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.teacherRootPage);
                  },
                  child: Text("লগইন"),
                ),
              ),
              Text(
                "Forget pin?/New Pin",
                style: AppTextStyles.normalLight(
                  context,
                ).copyWith(color: Color(0xFF012ea1), fontSize: 14),
              ),
            ],
          ),
        ),

        bottomNavigationBar: CustomFooter(),
      ),
    );
  }
}
