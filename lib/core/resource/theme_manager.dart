import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/font_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/style_manager.dart';
import 'package:dr_oplawrence_bible/core/resource/values_manager.dart';
import 'package:flutter/material.dart';
 
ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false, // set true if using Material 3
    // ===== Main colors =====
    primaryColor: ColorsManager.primaryColor,
    primaryColorLight: ColorsManager.primaryLight,
    primaryColorDark: ColorsManager.primaryDark,
    disabledColor: ColorsManager.secondaryTextColor,
    splashColor: ColorsManager.whiteColor,
    scaffoldBackgroundColor: ColorsManager.whiteColor,
 
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorsManager.primaryDark,
      error: ColorsManager.errorColor,
    ),
 
    // ===== Card Theme =====
    cardTheme: CardThemeData(
      color: ColorsManager.whiteColor,
      shadowColor: ColorsManager.secondaryTextColor,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
 
    // ===== AppBar Theme =====
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorsManager.primaryColor,
      elevation: AppSize.s4,
      iconTheme: IconThemeData(color: ColorsManager.whiteColor),
      titleTextStyle: getSemiBoldStyle(
        color: ColorsManager.whiteColor,
        fontSize: FontSize.s16,
      ),
    ),
 
    // ===== Button Theme =====
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorsManager.secondaryTextColor,
      buttonColor: ColorsManager.primaryColor,
      splashColor: ColorsManager.primaryDark,
    ),
 
    // ===== Elevated Button Theme =====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primaryColor,
        foregroundColor: ColorsManager.whiteColor,
        textStyle: getRegularStyle(
          color: ColorsManager.whiteColor,
          fontSize: FontSize.s16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
      ),
    ),
 
    // ===== Text Theme =====
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorsManager.blackColor,
        fontSize: FontSize.s20,
      ),
      titleMedium: getMediunStyle(
        color: ColorsManager.blackColor,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegularStyle(
        color: ColorsManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorsManager.primaryTextColor,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBoldStyle(
        color: ColorsManager.primaryTextColor,
        fontSize: FontSize.s14,
      ),
    ),
 
    // ===== Cursor & Selection Colors =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorsManager.primaryTextColor,
      selectionColor: ColorsManager.primaryColor.withValues(alpha: 0.1),
      selectionHandleColor: ColorsManager.primaryColor,
    ),
 
    // ===== Input Field Theme =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.whiteColor,
      hintStyle: getRegularStyle(color: ColorsManager.secondaryTextColor),
      labelStyle: getMediunStyle(color: ColorsManager.blackColor),
      helperStyle: getRegularStyle(color: ColorsManager.blackColor),
      errorStyle: getRegularStyle(color: ColorsManager.errorColor),
      contentPadding: const EdgeInsets.all(AppPadding.p12),
 
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
        
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.textFormBorderColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSize.s8),
        ),
      ),
    ),
 
    // ===== Icon Theme =====
    iconTheme: IconThemeData(
      color: ColorsManager.primaryColor,
      size: AppSize.s24,
    ),
  );
}