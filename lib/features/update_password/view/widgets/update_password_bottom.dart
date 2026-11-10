part of '../update_password_screen.dart';

class _UpdatePasswordBottom extends StatelessWidget {
  const _UpdatePasswordBottom();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UpdatePasswordCubit>();

    return BlocBuilder<UpdatePasswordCubit, UpdatePasswordState>(
      builder: (context, state) {
        return CustomButton(
          text: 'update_password'.tr(),
          isLoading: state is UpdatePasswordLoadingState,
          onPressed: cubit.update,
        );
      },
    );
  }
}
