part of '../login_screen.dart';

class _LoginBody extends StatelessWidget {
  const _LoginBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
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
        const SizedBox(height: 16),
        CustomTextField(
          controller: cubit.passwordController,
          hintText: 'password'.tr(),
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'password_required'.tr();
            }
            return null;
          },
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppPages.forgotPasswordScreen,
                arguments: cubit.emailController.text.trim(),
              );
            },
            child: Text('forgot_password'.tr()),
          ),
        ),
      ],
    );
  }
}
