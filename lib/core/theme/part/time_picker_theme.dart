import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTimePickerTheme {
  static TimePickerThemeData timePickerTheme = TimePickerThemeData(
    hourMinuteColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? ColorsManager.primaryColor
          : Colors.white;
    }),
    hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : ColorsManager.primaryColor;
    }),
    dayPeriodColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? ColorsManager.primaryColor
          : Colors.white;
    }),
    dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
      return states.contains(WidgetState.selected)
          ? Colors.white
          : ColorsManager.primaryColor;
    }),
    backgroundColor: Colors.white,
    dialHandColor: ColorsManager.primaryColor,
    helpTextStyle: TextStyle(color: Colors.white),
  );
}
