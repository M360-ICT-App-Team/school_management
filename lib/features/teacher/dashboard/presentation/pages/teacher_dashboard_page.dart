import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_management/core/constants/app_colors.dart';
import 'package:school_management/core/constants/app_sizes.dart';
import 'package:school_management/core/widgets/app_bar.dart';
import 'package:school_management/features/teacher/profile/presentation/bloc/teacher_profile_bloc.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../profile/data/model/teacher_profile_response_model.dart';
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
              child: BlocBuilder<TeacherProfileBloc, TeacherProfileState>(
                builder: (context, state) {
                  TeacherProfileResponseModel? teacherProfile;
                  if (state is TeacherProfileSuccess) { 
                    teacherProfile = state.teacherProfileResponseModel;
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppImages.logo, height: 120, width: 120),
                       Expanded(child: TeacherHeaderWidget( 
                        teacherProfile: teacherProfile,
                      )),
                    ],
                  );
                },
              ),
            ),
            Image.asset(AppImages.cyberNotice),
            Divider(color: AppColors.lightGrey, thickness: 1),

            //! Menu without GridView
            TeacherMenuWidget(),
          ],
        ),
      ),
    );
  }
}
