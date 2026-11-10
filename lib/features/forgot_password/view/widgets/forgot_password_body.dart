part of '../forgot_password_screen.dart';

class _ForgotPasswordBody extends StatelessWidget {
  const _ForgotPasswordBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return CustomTextField(
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
    );
  }
}
