import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/features/onboarding/view_model/cubit.dart';
import 'package:shoply_clone/features/onboarding/view_model/state.dart';

part 'widgets/onboarding_header.dart';
part 'widgets/onboarding_bottom.dart';

const _images = [
  'assets/images/onboard_1.png',
  'assets/images/onboard_2.png',
  'assets/images/onboard_3.png',
];

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: BlocListener<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingFinishedState) {
              Navigator.pushReplacementNamed(context, AppPages.loginScreen);
            }
          },
          child: const SafeArea(
            child: Column(
              children: [
                Expanded(flex: 2, child: _OnboardingHeader()),
                Expanded(child: _OnboardingBottom()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
