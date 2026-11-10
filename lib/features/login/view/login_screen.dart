import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/regex/app_regex.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/features/login/view_model/cubit.dart';
import 'package:shoply_clone/features/login/view_model/state.dart';
import 'package:shoply_clone/core/helper/language_helper.dart';
part 'widgets/login_header.dart';
part 'widgets/login_body.dart';
part 'widgets/login_bottom.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorState) {
              CustomSnackBar.show(context, state.errorMessage);
            } else if (state is LoginSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                state.isEmailVerified
                    ? AppPages.mainScreen
                    : AppPages.verifyEmailScreen,
                (route) => false,
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<LoginCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: cubit.formKey,
                    child: const Column(
                      children: [
                        SizedBox(height: 16),
                        _LoginHeader(),
                        SizedBox(height: 32),
                        _LoginBody(),
                        SizedBox(height: 24),
                        _LoginBottom(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
