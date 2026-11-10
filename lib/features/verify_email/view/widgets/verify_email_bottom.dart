part of '../verify_email_screen.dart';

class _VerifyEmailBottom extends StatelessWidget {
  const _VerifyEmailBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VerifyEmailCubit>();

    return Column(
      children: [
        BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
          builder: (context, state) {
            return CustomButton(
              text: 'ive_verified'.tr(),
              isLoading: state is VerifyEmailLoadingState,
              onPressed: cubit.checkVerified,
            );
          },
        ),
        const SizedBox(height: 8),
        TextButton(onPressed: cubit.resend, child: Text('resend_email'.tr())),
        TextButton(
          onPressed: cubit.backToLogin,
          child: Text('back_to_login'.tr()),
        ),
      ],
    );
  }
}
