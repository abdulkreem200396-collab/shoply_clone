import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xffffffff);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color primaryColor = Color(0xFF0A5C43);
  static const Color primaryDark = Color(0xFF2E9E78);
  static const Color onPrimary = Color(0xffffffff);
  static const Color secondary = Color(0xFFE8F3EE);

  // لون الكروت النصية (غير مربعات الصور) حسب الوضع
  static Color card(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF5F5F5);
  }
}
