part of '../main_screen.dart';

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  // بنسكّر القائمة، وبنفتح الصفحة، ولما نرجع بنحدّث الاسم والصورة (ممكن تغيّروا)
  Future<void> _open(BuildContext context, String route) async {
    final navigator = Navigator.of(context);
    final profileCubit = context.read<ProfileCubit>();
    final homeCubit = context.read<HomeCubit>();

    await navigator.pushNamed(route);

    profileCubit.load();
    homeCubit.loadUser();
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          content: Text('logout_confirm'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text('cancel'.tr()),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text('logout'.tr()),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      context.read<ProfileCubit>().logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const _MainDrawerHeader(),
            const Divider(),
            CustomListTile(
              icon: Icons.receipt_long_outlined,
              title: 'my_orders'.tr(),
              onTap: () => _open(context, AppPages.ordersScreen),
            ),
            CustomListTile(
              icon: Icons.settings_outlined,
              title: 'settings'.tr(),
              onTap: () => _open(context, AppPages.settingsScreen),
            ),
            CustomListTile(
              icon: Icons.info_outline,
              title: 'about'.tr(),
              onTap: () => _open(context, AppPages.aboutScreen),
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final isAdmin =
                    context.read<ProfileCubit>().profile?.isAdmin ?? false;
                if (!isAdmin) return const SizedBox.shrink();

                return CustomListTile(
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'admin_panel'.tr(),
                  onTap: () => _open(context, AppPages.adminScreen),
                );
              },
            ),
            const Spacer(),
            CustomListTile(
              icon: Icons.logout,
              title: 'logout'.tr(),
              color: Colors.red,
              showArrow: false,
              onTap: () => _confirmLogout(context),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _MainDrawerHeader extends StatelessWidget {
  const _MainDrawerHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final profile = context.read<ProfileCubit>().profile;
        final name = profile?.fullName ?? '';

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Row(
            children: [
              UserAvatar(bytes: profile?.photo, radius: 34),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'shoply_user'.tr() : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile?.email ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
