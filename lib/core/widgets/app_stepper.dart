import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppStepper extends StatelessWidget {
  const AppStepper({super.key, required this.totalStep, required this.completedStep});
  final int totalStep, completedStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(totalStep, (index) {
        return Expanded(
          child: AnimatedContainer(
            margin: EdgeInsets.only(left: index == 0 ? 0 : 5),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: index < completedStep ? AppColors.primary : AppColors.fill,
            ), duration: Duration(milliseconds: 300),
          ),
        );
      }),
    );
  }
}