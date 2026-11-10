part of '../login_screen.dart';

class _LoginBottom extends StatelessWidget {
  const _LoginBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Column(
      children: [
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return CustomButton(
              text: 'login'.tr(),
              isLoading: state is LoginLoadingState,
              onPressed: cubit.login,
            );
          },
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dont_have_account'.tr()),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppPages.signupScreen);
              },
              child: Text('sign_up'.tr()),
            ),
          ],
        ),
      ],
    );
  }
}
