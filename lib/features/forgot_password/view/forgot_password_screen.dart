import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/regex/app_regex.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/features/forgot_password/view_model/cubit.dart';
import 'package:shoply_clone/features/forgot_password/view_model/state.dart';

part 'widgets/forgot_password_header.dart';
part 'widgets/forgot_password_body.dart';
part 'widgets/forgot_password_bottom.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key, this.initialEmail = ''});

  final String initialEmail;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordCubit(initialEmail: initialEmail),
      child: Scaffold(
        appBar: AppBar(scrolledUnderElevation: 0),
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordErrorState) {
              CustomSnackBar.show(context, state.errorMessage);
            } else if (state is ForgotPasswordSuccessState) {
              CustomSnackBar.show(context, 'reset_sent'.tr());
              Navigator.pop(context);
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<ForgotPasswordCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: cubit.formKey,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        _ForgotPasswordHeader(),
                        SizedBox(height: 32),
                        _ForgotPasswordBody(),
                        SizedBox(height: 24),
                        _ForgotPasswordBottom(),
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
