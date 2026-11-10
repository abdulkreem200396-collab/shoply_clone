import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/image_picker_helper.dart';
import 'package:shoply_clone/core/regex/app_regex.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/core/utils/widgets/user_avatar/user_avatar.dart';
import 'package:shoply_clone/features/signup/view_model/cubit.dart';
import 'package:shoply_clone/features/signup/view_model/state.dart';

part 'widgets/signup_header.dart';
part 'widgets/signup_body.dart';
part 'widgets/signup_bottom.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        body: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupErrorState) {
              CustomSnackBar.show(context, state.errorMessage);
            } else if (state is SignupSuccessState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.verifyEmailScreen,
                (route) => false,
              );
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<SignupCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: cubit.formKey,
                    child: const Column(
                      children: [
                        SizedBox(height: 12),
                        _SignupHeader(),
                        SizedBox(height: 20),
                        _SignupBody(),
                        SizedBox(height: 24),
                        _SignupBottom(),
                        SizedBox(height: 12),
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
