import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppTextTheme {
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.ubuntuSans(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.ubuntuSans(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.ubuntuSans(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),

    bodyLarge: GoogleFonts.inter(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),

    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11,
      fontWeight: FontWeight.w400,
    ),
  );
}
