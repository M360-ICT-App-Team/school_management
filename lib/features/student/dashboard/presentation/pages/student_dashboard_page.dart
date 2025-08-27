

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../../core/widgets/app_image_view.dart';
import '../../../profile/data/model/student_profile_response_model.dart';
import '../../../profile/presentation/bloc/student_profile_bloc.dart';
import '../widgets/student_header_widget.dart';
import '../widgets/student_menu_widget.dart';

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: CustomAppBar(showBack: false),
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
            child: BlocBuilder<StudentProfileBloc, StudentProfileState>(
              builder: (context, state) {
                StudentProfileResponseModel? studentProfile;
                if (state is StudentProfileSuccess) {
                  studentProfile = state.studentProfileResponseModel;
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "profile_image",
                      child: AppCachedNetworkImage(
                        url: studentProfile?.photo ?? "",
                        height: 100,
                        width: 100,
                        isPerson: false,
                      ),
                    ),
                    Expanded(
                      child: StudentHeaderWidget(
                        studentProfile: studentProfile,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Image.asset(AppImages.cyberNotice),
          Divider(color: AppColors.lightGrey, thickness: 1),

          //! Menu without GridView
          StudentMenuWidget(),
        ],
      ),
    );
  }
}
