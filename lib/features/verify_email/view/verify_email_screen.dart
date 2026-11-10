import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/features/verify_email/view_model/cubit.dart';
import 'package:shoply_clone/features/verify_email/view_model/state.dart';

part 'widgets/verify_email_header.dart';
part 'widgets/verify_email_bottom.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyEmailCubit(),
      child: Scaffold(
        body: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailErrorState) {
              CustomSnackBar.show(context, state.message);
            } else if (state is VerifyEmailNotVerifiedState) {
              CustomSnackBar.show(context, 'not_verified_yet'.tr());
            } else if (state is VerifyEmailResentState) {
              CustomSnackBar.show(context, 'email_sent_again'.tr());
            } else if (state is VerifyEmailVerifiedState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.mainScreen,
                (route) => false,
              );
            } else if (state is VerifyEmailSignedOutState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            }
          },
          child: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _VerifyEmailHeader(),
                  SizedBox(height: 32),
                  _VerifyEmailBottom(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
