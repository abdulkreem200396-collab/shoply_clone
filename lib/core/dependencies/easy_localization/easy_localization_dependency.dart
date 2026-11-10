import 'package:easy_localization/easy_localization.dart';

class EasyLocalizationDependency {
  static Future<void> initEasyLocalizationDependency() async {
    await EasyLocalization.ensureInitialized();
  }
}
