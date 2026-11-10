part of '../edit_profile_screen.dart';

class _EditProfileBody extends StatelessWidget {
  const _EditProfileBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();

    return Column(
      children: [
        CustomTextField(
          controller: cubit.nameController,
          hintText: 'full_name'.tr(),
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'name_required'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.usernameController,
          hintText: 'username'.tr(),
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.addressController,
          hintText: 'delivery_address'.tr(),
          prefixIcon: Icons.location_on_outlined,
        ),
        const SizedBox(height: 24),
        BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return CustomButton(
              text: 'save'.tr(),
              isLoading: state is EditProfileSavingState,
              onPressed: cubit.save,
            );
          },
        ),
      ],
    );
  }
}
