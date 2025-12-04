import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';

class CustomDatePickerTheme {
  static DatePickerThemeData datePickerTheme = DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: ColorsManager.primaryColor,
    headerForegroundColor: Colors.white,
    dayForegroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white;
      } else if (states.contains(WidgetState.disabled)) {
        return Colors.grey;
      }
      return ColorsManager.primaryColor;
    }),
    dayBackgroundColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return ColorsManager.primaryColor;
      } else if (states.contains(WidgetState.disabled)) {
        return Colors.grey.shade200;
      }
      return Colors.transparent;
    }),
    todayForegroundColor: WidgetStatePropertyAll(ColorsManager.primaryColor),
    todayBackgroundColor: WidgetStatePropertyAll(
      ColorsManager.primaryColor,
    ),
    yearForegroundColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : ColorsManager.primaryColor;
    }),
    yearBackgroundColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? ColorsManager.primaryColor
          : Colors.transparent;
    }),
  );
}
