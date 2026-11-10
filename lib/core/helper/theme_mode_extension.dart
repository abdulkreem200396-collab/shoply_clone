import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// اسم الخيار مترجم، بمكان واحد
extension ThemeModeLabel on ThemeMode {
  String get label {
    switch (this) {
      case ThemeMode.dark:
        return 'mode_dark'.tr();
      case ThemeMode.light:
        return 'mode_light'.tr();
      case ThemeMode.system:
        return 'mode_system'.tr();
    }
  }
}
