import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shoply_clone/core/helper/language_helper.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/option_tile/custom_option_tile.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  void _select(BuildContext context, String code) {
    LanguageHelper.setLanguage(context, code: code, route: AppPages.mainScreen);
  }

  @override
  Widget build(BuildContext context) {
    final code = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'language'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomOptionTile(
            icon: Icons.translate,
            title: 'العربية',
            selected: code == 'ar',
            onTap: () => _select(context, 'ar'),
          ),
          const SizedBox(height: 12),
          CustomOptionTile(
            icon: Icons.translate,
            title: 'English',
            selected: code == 'en',
            onTap: () => _select(context, 'en'),
          ),
        ],
      ),
    );
  }
}
