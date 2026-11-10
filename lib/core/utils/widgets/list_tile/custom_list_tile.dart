import 'package:flutter/material.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';

// صف قائمة: أيقونة + عنوان + سهم. بيشتغل بالقائمة الجانبية (بدون إطار) وبالإعدادات (ككرت)
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.color,
    this.showArrow = true,
    this.isCard = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? color;
  final bool showArrow;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: showArrow ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );

    if (!isCard) return tile;

    return Material(
      color: AppColors.card(context),
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: tile,
    );
  }
}
