part of '../signup_screen.dart';

class _SignupHeader extends StatelessWidget {
  const _SignupHeader();

  Future<void> _pickPhoto(BuildContext context) async {
    final bytes = await pickProfileImage(context);
    if (bytes == null || !context.mounted) return;
    context.read<SignupCubit>().setPhoto(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            Text(
              'create_account'.tr(),
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'join_us'.tr(),
          style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 20),
        BlocBuilder<SignupCubit, SignupState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => _pickPhoto(context),
              child: Stack(
                children: [
                  UserAvatar(bytes: cubit.photoBytes, radius: 55),
                  PositionedDirectional(
                    bottom: 0,
                    end: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: primary,
                      child: const Icon(
                        Icons.camera_alt,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
