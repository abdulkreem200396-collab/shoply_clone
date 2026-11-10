import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/routes/app_routes.dart';
import 'package:shoply_clone/core/utils/theme/app_theme.dart';
import 'package:shoply_clone/features/cart/view_model/cubit.dart';
import 'package:shoply_clone/features/categories/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/cubit.dart';
import 'package:shoply_clone/features/products/view_model/cubit.dart';
import 'package:shoply_clone/features/theme/view_model/cubit.dart';
import 'package:shoply_clone/features/theme/view_model/state.dart';

class ShoplyApp extends StatelessWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => FavouriteCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ProductsCubit()..load()),
        BlocProvider(create: (context) => CategoriesCubit()..load()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shoply',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.mode,
            initialRoute: AppPages.splashScreen,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
