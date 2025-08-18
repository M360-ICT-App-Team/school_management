import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true
  ),
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
  ),
  scaffoldBackgroundColor: AppColors.white,
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      fixedSize: Size(double.maxFinite, AppSizes.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.buttonText,
        fontFamily: 'Lato',
      ),
      backgroundColor: AppColors.primary,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Color.alphaBlend(
      Colors.white.withValues(alpha: 0.95), 
      AppColors.primary
    ), // Blend with white
    fixedSize: Size(double.maxFinite, AppSizes.buttonHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
    ),
    textStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: AppSizes.buttonText,
      fontFamily: 'Lato',
    ),
  ),
),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      fixedSize: Size(double.maxFinite, AppSizes.buttonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
      ),
      side: BorderSide(color: AppColors.secondary, width: 0.5),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.buttonText,
        fontFamily: 'Lato',
      ),
    ),
  ),
  dividerTheme: DividerThemeData(thickness: 0.5, color: AppColors.subtitle),
  cardTheme: CardThemeData(
    shadowColor: Colors.transparent,
    elevation: 0,
    color: Colors.grey.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSizes.textFieldRadius),
      ),
    ),
  ),
  tabBarTheme: TabBarThemeData(
    dividerColor: AppColors.lightGrey,
    tabAlignment: TabAlignment.start,
  ),
);
