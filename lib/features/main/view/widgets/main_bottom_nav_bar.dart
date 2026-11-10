part of '../main_screen.dart';

class _MainBottomNavBar extends StatelessWidget {
  const _MainBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MainCubit>();

    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: cubit.currentIndex,
          onTap: cubit.changeTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: 'nav_home'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.grid_view),
              label: 'nav_categories'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.favorite_border),
              activeIcon: const Icon(Icons.favorite),
              label: 'nav_favorite'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart_outlined),
              activeIcon: const Icon(Icons.shopping_cart),
              label: 'nav_cart'.tr(),
            ),
          ],
        );
      },
    );
  }
}
