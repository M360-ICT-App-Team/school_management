import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';


Widget buildSegment(String text, bool isSelected, {Color selectedTextColor = AppColors.textBlack1, Color textColor = AppColors.bg}) {
  return Text(
    text.replaceAll(" ", "\n"),
    // text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16.sp,
      color: isSelected ? selectedTextColor : textColor,
    ),
  );
}
