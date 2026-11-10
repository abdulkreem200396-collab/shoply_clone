import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageHelper {
  static bool isArabic(BuildContext context) {
    return context.locale.languageCode == 'ar';
  }

  // بنبدّل اللغة وبنفتح المسار من جديد عشان كل الشاشات تنبني باللغة الجديدة
  static Future<void> setLanguage(
    BuildContext context, {
    required String code,
    required String route,
  }) async {
    if (context.locale.languageCode == code) return;

    await context.setLocale(Locale(code));
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
  }

  static Future<void> toggle(BuildContext context, {required String route}) {
    return setLanguage(
      context,
      code: isArabic(context) ? 'en' : 'ar',
      route: route,
    );
  }
}
