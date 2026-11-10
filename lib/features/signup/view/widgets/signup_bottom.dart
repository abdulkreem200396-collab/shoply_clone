part of '../signup_screen.dart';

class _SignupBottom extends StatelessWidget {
  const _SignupBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();

    return Column(
      children: [
        BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return CustomButton(
              text: 'sign_up'.tr(),
              isLoading: state is SignupLoadingState,
              onPressed: cubit.signup,
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('already_have_account'.tr()),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('login'.tr()),
            ),
          ],
        ),
      ],
    );
  }
}
