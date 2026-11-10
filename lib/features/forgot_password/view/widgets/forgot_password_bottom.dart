part of '../forgot_password_screen.dart';

class _ForgotPasswordBottom extends StatelessWidget {
  const _ForgotPasswordBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    return BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
      builder: (context, state) {
        return CustomButton(
          text: 'send_reset_link'.tr(),
          isLoading: state is ForgotPasswordLoadingState,
          onPressed: cubit.send,
        );
      },
    );
  }
}
