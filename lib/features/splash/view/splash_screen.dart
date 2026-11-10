import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/splash/view_model/cubit.dart';
import 'package:shoply_clone/features/splash/view_model/state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..start(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateState) {
              Navigator.pushReplacementNamed(context, state.route);
            }
          },
          child: Center(
            child: Image.asset(
              'assets/images/shoply_splash.png',
              width: 350,
              height: 350,
            ),
          ),
        ),
      ),
    );
  }
}
