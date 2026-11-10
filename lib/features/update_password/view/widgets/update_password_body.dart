part of '../update_password_screen.dart';

class _UpdatePasswordBody extends StatelessWidget {
  const _UpdatePasswordBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdatePasswordCubit>();

    return Column(
      children: [
        CustomTextField(
          controller: cubit.currentController,
          hintText: 'current_password'.tr(),
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.newController,
          hintText: 'new_password'.tr(),
          prefixIcon: Icons.lock_reset,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            if (!AppRegex.isPasswordValid(value)) {
              return 'password_min_length'.tr();
            }
            if (value == cubit.currentController.text) {
              return 'password_same_as_old'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.confirmController,
          hintText: 'confirm_new_password'.tr(),
          prefixIcon: Icons.lock_reset,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            if (value != cubit.newController.text) {
              return 'passwords_do_not_match'.tr();
            }
            return null;
          },
        ),
      ],
    );
  }
}
