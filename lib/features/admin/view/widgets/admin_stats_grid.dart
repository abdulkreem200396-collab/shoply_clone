part of '../admin_screen.dart';

class _AdminStatsGrid extends StatelessWidget {
  const _AdminStatsGrid({required this.stats});

  final AdminStats stats;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _StatCard(
          icon: Icons.inventory_2_outlined,
          label: 'total_products'.tr(),
          value: '${stats.productsCount}',
        ),
        _StatCard(
          icon: Icons.receipt_long_outlined,
          label: 'total_orders'.tr(),
          value: '${stats.ordersCount}',
        ),
        _StatCard(
          icon: Icons.hourglass_bottom,
          label: 'pending_orders'.tr(),
          value: '${stats.pendingCount}',
        ),
        _StatCard(
          icon: Icons.attach_money,
          label: 'revenue'.tr(),
          value: '\$${stats.revenue.toStringAsFixed(2)}',
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
