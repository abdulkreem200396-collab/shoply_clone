import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shoply_clone/core/dependencies/main/main_dependency.dart';
import 'package:shoply_clone/features/app/view/shoply_app.dart';

Future<void> main() async {
  await MainDependency.mainInitDependency();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const ShoplyApp(),
    ),
  );
}
