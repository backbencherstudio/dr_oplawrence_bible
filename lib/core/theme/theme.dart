import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/theme/part/app_bar_theme.dart';
import 'package:dr_oplawrence_bible/core/theme/part/date_picker_theme.dart';
import 'package:dr_oplawrence_bible/core/theme/part/elevated_button_theme.dart';
import 'package:dr_oplawrence_bible/core/theme/part/input_decoration_theme.dart';
import 'package:dr_oplawrence_bible/core/theme/part/time_picker_theme.dart';
import 'package:dr_oplawrence_bible/core/theme/theme_extension/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.primaryColor,
    ),
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationTheme,
    scaffoldBackgroundColor: ColorsManager.whiteColor,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: AppEvaluatedButtonThemes.evaluatedButtonTheme,
    textTheme: AppTextTheme.darkTextTheme,
    //colorScheme: AppColors.darkColorScheme,
    timePickerTheme: CustomTimePickerTheme.timePickerTheme,
    datePickerTheme: CustomDatePickerTheme.datePickerTheme,
  );
  static ThemeData darkTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.primaryColor,
    ),
    inputDecorationTheme: AppInputDecorationTheme.inputDecorationTheme,
    scaffoldBackgroundColor: ColorsManager.whiteColor,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: AppEvaluatedButtonThemes.evaluatedButtonTheme,
    textTheme: AppTextTheme.darkTextTheme,
    // colorScheme: AppColors.darkColorScheme,
    timePickerTheme: CustomTimePickerTheme.timePickerTheme,
    datePickerTheme: CustomDatePickerTheme.datePickerTheme,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.whiteColor,
      selectedItemColor: ColorsManager.primaryColor,
      unselectedItemColor: ColorsManager.primaryColor,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
      showUnselectedLabels: true,
    ),
  );
}
