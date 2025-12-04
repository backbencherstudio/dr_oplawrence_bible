import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: ColorsManager.secondaryTextColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: TextStyle(
      color: ColorsManager.errorColor, // Change error text color
      fontSize: 12, // Change font size
      // Make it bold
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      // borderSide: BorderSide(color: AppColors.borderColor,),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: ColorsManager.textFormBorderColor,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      // borderSide: BorderSide(color: AppColors.borderColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorsManager.errorColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: ColorsManager.errorColor),
    ),

    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      // borderSide: BorderSide(color: AppColors.borderColor,),
    ),

    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    filled: true,
    fillColor: ColorsManager.textFormFillColor,
    focusColor: ColorsManager.whiteColor,
    hoverColor: ColorsManager.primaryColor,
  );
}
