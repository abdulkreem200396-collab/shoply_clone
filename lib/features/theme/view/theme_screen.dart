import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/theme_mode_extension.dart';
import 'package:shoply_clone/core/utils/widgets/option_tile/custom_option_tile.dart';
import 'package:shoply_clone/features/theme/view_model/cubit.dart';
import 'package:shoply_clone/features/theme/view_model/state.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mode'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CustomOptionTile(
                icon: Icons.dark_mode_outlined,
                title: ThemeMode.dark.label,
                selected: state.mode == ThemeMode.dark,
                onTap: () => cubit.setMode(ThemeMode.dark),
              ),
              const SizedBox(height: 12),
              CustomOptionTile(
                icon: Icons.light_mode_outlined,
                title: ThemeMode.light.label,
                selected: state.mode == ThemeMode.light,
                onTap: () => cubit.setMode(ThemeMode.light),
              ),
              const SizedBox(height: 12),
              CustomOptionTile(
                icon: Icons.brightness_auto_outlined,
                title: ThemeMode.system.label,
                subtitle: 'mode_system_desc'.tr(),
                selected: state.mode == ThemeMode.system,
                onTap: () => cubit.setMode(ThemeMode.system),
              ),
            ],
          );
        },
      ),
    );
  }
}
