part of '../main_screen.dart';

class _MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MainAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // ما كتبنا leading: الـ Scaffold بيحط زر القائمة (☰) لحاله لأنو عنده drawer
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Shoply',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pushNamed(context, AppPages.searchScreen),
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }
}
