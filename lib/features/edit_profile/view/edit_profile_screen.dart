import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/image_picker_helper.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_clone/core/utils/widgets/user_avatar/user_avatar.dart';
import 'package:shoply_clone/features/edit_profile/view_model/cubit.dart';
import 'package:shoply_clone/features/edit_profile/view_model/state.dart';

part 'widgets/edit_profile_header.dart';
part 'widgets/edit_profile_body.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'update_profile'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSavedState) {
              Navigator.pop(context, true);
            } else if (state is EditProfileErrorState) {
              CustomSnackBar.show(context, state.message);
            }
          },
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) {
              if (state is EditProfileInitState ||
                  state is EditProfileLoadingState) {
                return const CustomLoading();
              }

              final cubit = context.read<EditProfileCubit>();
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: cubit.formKey,
                  child: const Column(
                    children: [
                      _EditProfileHeader(),
                      SizedBox(height: 24),
                      _EditProfileBody(),
                    ],
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
