part of '../admin_screen.dart';

class _AdminActions extends StatelessWidget {
  const _AdminActions();

  // بنفتح الشاشة، ولما نرجع بنحدّث الأرقام
  Future<void> _open(BuildContext context, String route) async {
    final cubit = context.read<AdminCubit>();
    await Navigator.pushNamed(context, route);
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomListTile(
          isCard: true,
          icon: Icons.inventory_2_outlined,
          title: 'manage_products'.tr(),
          onTap: () => _open(context, AppPages.adminProductsScreen),
        ),
        const SizedBox(height: 12),
        CustomListTile(
          isCard: true,
          icon: Icons.local_shipping_outlined,
          title: 'manage_orders'.tr(),
          onTap: () => _open(context, AppPages.adminOrdersScreen),
        ),
      ],
    );
  }
}
