import 'package:flutter/material.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';

// خيار واحد من عدة خيارات (اللغة، المظهر): الخيار المختار بيظهر بإطار وعلامة صح
class CustomOptionTile extends StatelessWidget {
  const CustomOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Material(
      color: AppColors.card(context),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected ? primary : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: selected ? primary : null),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: Icon(
          selected ? Icons.check_circle : Icons.radio_button_unchecked,
          color: selected ? primary : Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
