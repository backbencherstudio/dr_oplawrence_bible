import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppAppBarTheme {
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: ColorsManager.primaryColor,
    actionsPadding: EdgeInsets.all(10),
    titleTextStyle: GoogleFonts.roboto(
      textStyle: TextStyle(
        color: ColorsManager.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
