import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/list_tile/custom_list_tile.dart';
import 'package:shoply_clone/core/utils/widgets/user_avatar/user_avatar.dart';
import 'package:shoply_clone/features/cart/view/cart_screen.dart';
import 'package:shoply_clone/features/categories/view/categories_screen.dart';
import 'package:shoply_clone/features/favourite/view/favourite_screen.dart';
import 'package:shoply_clone/features/home/view/home_screen.dart';
import 'package:shoply_clone/features/home/view_model/cubit.dart';
import 'package:shoply_clone/features/main/view_model/cubit.dart';
import 'package:shoply_clone/features/main/view_model/state.dart';
import 'package:shoply_clone/features/profile/view_model/cubit.dart';
import 'package:shoply_clone/features/profile/view_model/state.dart';

part 'widgets/main_app_bar.dart';
part 'widgets/main_bottom_nav_bar.dart';
part 'widgets/main_drawer.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainCubit()),
        BlocProvider(create: (context) => HomeCubit()..loadUser()),
        BlocProvider(create: (context) => ProfileCubit()..load()),
      ],
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoggedOutState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppPages.loginScreen,
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: const _MainAppBar(),
          drawer: const _MainDrawer(),
          body: BlocBuilder<MainCubit, MainState>(
            builder: (context, state) {
              switch (context.read<MainCubit>().currentIndex) {
                case 1:
                  return const CategoriesScreen();
                case 2:
                  return const FavouriteScreen();
                case 3:
                  return const CartScreen();
                default:
                  return const HomeScreen();
              }
            },
          ),
          bottomNavigationBar: const _MainBottomNavBar(),
        ),
      ),
    );
  }
}
