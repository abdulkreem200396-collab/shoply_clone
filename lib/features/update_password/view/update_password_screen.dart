import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/regex/app_regex.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/features/update_password/view_model/cubit.dart';
import 'package:shoply_clone/features/update_password/view_model/state.dart';

part 'widgets/update_password_body.dart';
part 'widgets/update_password_bottom.dart';

class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'update_password'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
          listener: (context, state) {
            if (state is UpdatePasswordErrorState) {
              CustomSnackBar.show(context, state.message);
            } else if (state is UpdatePasswordSuccessState) {
              CustomSnackBar.show(context, 'password_updated'.tr());
              Navigator.pop(context);
            }
          },
          child: Builder(
            builder: (context) {
              final cubit = context.read<UpdatePasswordCubit>();
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: cubit.formKey,
                    child: const Column(
                      children: [
                        _UpdatePasswordBody(),
                        SizedBox(height: 24),
                        _UpdatePasswordBottom(),
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
