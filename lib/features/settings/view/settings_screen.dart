import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/theme_mode_extension.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/list_tile/custom_list_tile.dart';
import 'package:shoply_clone/features/theme/view_model/cubit.dart';
import 'package:shoply_clone/features/theme/view_model/state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomListTile(
            isCard: true,
            icon: Icons.person_outline,
            title: 'update_profile'.tr(),
            onTap: () =>
                Navigator.pushNamed(context, AppPages.editProfileScreen),
          ),
          const SizedBox(height: 12),
          CustomListTile(
            isCard: true,
            icon: Icons.lock_outline,
            title: 'update_password'.tr(),
            onTap: () =>
                Navigator.pushNamed(context, AppPages.updatePasswordScreen),
          ),
          const SizedBox(height: 12),
          CustomListTile(
            isCard: true,
            icon: Icons.translate,
            title: 'language'.tr(),
            subtitle: isArabic ? 'العربية' : 'English',
            onTap: () => Navigator.pushNamed(context, AppPages.languageScreen),
          ),
          const SizedBox(height: 12),
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return CustomListTile(
                isCard: true,
                icon: Icons.brightness_6_outlined,
                title: 'mode'.tr(),
                subtitle: state.mode.label,
                onTap: () => Navigator.pushNamed(context, AppPages.themeScreen),
              );
            },
          ),
        ],
      ),
    );
  }
}
