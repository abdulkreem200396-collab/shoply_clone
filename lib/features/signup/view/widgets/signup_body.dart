part of '../signup_screen.dart';

class _SignupBody extends StatelessWidget {
  const _SignupBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

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
          controller: cubit.emailController,
          hintText: 'email'.tr(),
          prefixIcon: Icons.mail_outline,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'email_required'.tr();
            }
            if (!AppRegex.isEmailValid(value)) {
              return 'invalid_email'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.addressController,
          hintText: 'address'.tr(),
          prefixIcon: Icons.location_on_outlined,
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.passwordController,
          hintText: 'password'.tr(),
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            if (!AppRegex.isPasswordValid(value)) {
              return 'password_min_length'.tr();
            }
            return null;
          },
        ),
        const SizedBox(height: 14),
        CustomTextField(
          controller: cubit.confirmController,
          hintText: 'confirm_password'.tr(),
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            if (value != cubit.passwordController.text) {
              return 'passwords_do_not_match'.tr();
            }
            return null;
          },
        ),
      ],
    );
  }
}
