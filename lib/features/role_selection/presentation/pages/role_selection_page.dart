import 'package:flutter/material.dart';
import 'package:school_management/app/route/app_routes.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/constants/app_text_styles.dart';
import 'package:school_management/core/local_database/auth_db.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/app_footer.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const CustomAppBar(showBack: false),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.bodyPadding * 2,
            vertical: AppSizes.bodyPadding * 4,
          ),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
            children: [
              _buildRoleCard(context, AppImages.principal, "বিভাগীয় প্রধান"),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.teacherLoginPage);
                  AuthLocalDB.setRole(AuthLocalDB.teacher);
                },
                child: _buildRoleCard(context, AppImages.teacher, "শিক্ষক"),
              ),
              _buildRoleCard(context, AppImages.parent, "অভিভাবক"),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.studentLoginPage);
                  AuthLocalDB.setRole(AuthLocalDB.student);
                },
                child: _buildRoleCard(context, AppImages.student, "শিক্ষার্থী"),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomFooter(),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String image, String title) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSizes.cardRadius),
        boxShadow: [AppColors.appShadow],
        border: Border.all(color: AppColors.blue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 80,
              child: Divider(color: Colors.black, thickness: 1),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: AppTextStyles.normalBold(context),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
