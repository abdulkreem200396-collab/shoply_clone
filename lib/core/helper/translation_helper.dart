import 'package:easy_localization/easy_localization.dart';

class TranslationHelper {
  static bool get isArabic => 'lang_code'.tr() == 'ar';

  // الترجمة إذا لقينا مفتاح إلها، وإلا النص الأصلي
  static String tryTranslate(String key, {required String fallback}) {
    final translated = key.tr();
    return translated == key ? fallback : translated;
  }
}
