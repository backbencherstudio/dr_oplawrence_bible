import 'package:dr_oplawrence_bible/core/constansts/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppEvaluatedButtonThemes {
  AppEvaluatedButtonThemes._();

  //Light mode Evaluated Button Theme
  static final evaluatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      foregroundColor: ColorsManager.primaryColor,
      backgroundColor: ColorsManager.primaryColor,
      textStyle: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 18),
        color: ColorsManager.whiteColor,
      ),

      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
    ),
  );
}
