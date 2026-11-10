part of '../edit_profile_screen.dart';

class _EditProfileHeader extends StatelessWidget {
  const _EditProfileHeader();

  Future<void> _pickPhoto(BuildContext context) async {
    final bytes = await pickProfileImage(context);
    if (bytes == null || !context.mounted) return;
    context.read<EditProfileCubit>().setPhoto(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditProfileCubit>();
    final primary = Theme.of(context).colorScheme.primary;

    return BlocBuilder<EditProfileCubit, EditProfileState>(
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
    );
  }
}
