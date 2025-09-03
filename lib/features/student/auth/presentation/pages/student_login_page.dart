import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../../app/route/app_routes.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/app_adaptive_alert_dialog.dart';
import '../../../../../core/widgets/app_bar.dart';
import '../../../../../core/widgets/app_footer.dart';
import '../../../../../core/widgets/app_input_widgets.dart';
import '../../../../../core/widgets/app_snackbar.dart';
import '../../data/model/student_login_request_model.dart';
import '../bloc/student_auth_bloc.dart';

class StudentLoginPage extends StatefulWidget {
  const StudentLoginPage({super.key});

  @override
  State<StudentLoginPage> createState() => _StudentLoginPageState();
}

class _StudentLoginPageState extends State<StudentLoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isObscure = ValueNotifier<bool>(true);
  @override
  void dispose() {
    idController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: BlocListener<StudentAuthBloc, StudentAuthState>(
        listener: (context, state) {
          if (state is StudentLoginLoading) {
            AppBottomSheets.showLoading(context, message: "Logging in...");
          } else if (state is StudentLoginSuccess) {
            AppBottomSheets.hide(context);
            // context.read<StudentProfileBloc>().add(GetStudentProfileEvent());
    
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.studentRootPage,
              (route) => false,
            );
          } else if (state is StudentLoginError) {
            AppBottomSheets.hide(context);
            appAdaptiveDialog(context: context, message: state.message);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.bodyPadding * 8,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "শিক্ষার্থী",
                    style: AppTextStyles.normalLight(
                      context,
                    ).copyWith(fontSize: 24),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: AppTextField(
                    hintText: "আইডি",
                    controller: idController,
                    prefixIcon: Icon(
                      HugeIcons.strokeRoundedId,
                      color: AppColors.primary.withAlpha(70),
                    ),
                    validator: (p0) => p0!.isEmpty ? "আইডি লিখুন" : null,
                  ),
                ),
    
                ValueListenableBuilder(
                  valueListenable: isObscure,
                  builder: (context, value, child) {
                    return SizedBox(
                      width: 300,
                      child: AppTextField(
                        hintText: "পিন",
                        controller: pinController,
                        obscureText: value,
                        prefixIcon: Icon(
                          HugeIcons.strokeRoundedKey01,
                          color: AppColors.primary.withAlpha(70),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            value ? AppIcons.view : AppIcons.viewOff,
                          ),
                          onPressed: () {
                            isObscure.value = !value;
                          },
                        ),
                        validator: (p0) => p0!.isEmpty ? "পিন লিখুন" : null,
                      ),
                    );
                  },
                ),
    
                SizedBox(height: 20),
    
                BlocBuilder<StudentAuthBloc, StudentAuthState>(
                  builder: (context, state) {
                    final isLoading = state is StudentLoginLoading;
                    return SizedBox(
                      width: 140,
                      height: 40,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                        ),
                        onPressed: isLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  context.read<StudentAuthBloc>().add(
                                    StudentLoginEvent(
                                      studentLoginRequestModel:
                                          StudentLoginRequestModel(
                                            loginId: idController.text.trim(),
                                            password: pinController.text,
                                          ),
                                    ),
                                  );
                                }
                                // Navigator.pushNamed(
                                //   context,
                                //   AppRoutes.StudentRootPage,
                                // );
                              },
                        child: Text("লগইন"),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "Forget pin?/New Pin",
                  style: AppTextStyles.normalLight(
                    context,
                  ).copyWith(color: Color(0xFF012ea1), fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    
      bottomNavigationBar: CustomFooter(),
    );
  }
}