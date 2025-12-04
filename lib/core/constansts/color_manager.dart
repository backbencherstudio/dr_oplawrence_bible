import 'package:flutter/material.dart';



class ColorsManager {
  // 🌟 Base Colors

  static const Color primaryColor = Color(0xFF1570EF);
  static const Color secondaryColor = Color(0xFF1FB155);
  static const Color splashBgColor = Color(0xFF294889);

  // 🌞 Light Colors
  static const Color primaryLight = Color(0xFF5A98F2);
  static const Color backgroundLight = Color(0xFFF5F7FA);

  // 🌙 Dark Colors
  static const Color primaryDark = Color(0xFF0E4CAD);
  static const Color backgroundDark = Color(0xFF0D1117);

  // 🌈 Text Colors
  static const Color primaryTextColor = Color(0xFF2F3131);
  static const Color secondaryTextColor = Color(0xFF5B5F5F);
  static const Color greenTextColor = Color(0xFF147638);
  static const Color orangeTextColor = Color(0xFFA47D06);
  static const Color lightOrange = Color(0xFFFFEDB9);
  static const Color purpleTextColor = Color(0xFF6366F1);

  // ⚠️ Status Colors
  static const Color errorColor = Color(0xFFEF4444);
  static const Color lighterror = Color(0xFFFDECEC);
  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFFDF7E6);

  // 🧱 UI Colors
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static const Color textFormFillColor = Color(0xFFFFFFFF);
  static const Color textFormBorderColor = Color(0xFF858B8A);

  static const Color lightBlue = Color(0xFFE8F1FD);

  // 🔆 Variants using `.withValues()` (replaces `.withOpacity()`)
  static Color get primary10 => primaryColor.withValues(alpha: 0.1);
  static Color get primary20 => primaryColor.withValues(alpha: 0.2);
  static Color get primary30 => primaryColor.withValues(alpha: 0.3);
  static Color get primary50 => primaryColor.withValues(alpha: 0.5);
  static Color get primary70 => primaryColor.withValues(alpha: 0.7);

  static Color get error20 => errorColor.withValues(alpha: 0.05);
  static Color get white80 => whiteColor.withValues(alpha: 0.8);
  static Color get textSecondary50 => secondaryTextColor.withValues(alpha: 0.5);


  static const Color lightPurple = Color(0xFFD7DAFF);
  // card color
  static const Color jobCardColor = Color(0xFFF4F8FE);
  static const Color completeColor = Color(0xFFEFF0FE);
  static const Color ratedColor = Color(0xFFD7D7D7);
  static const Color confirmColor = Color(0xFFD6F5DA);

}
