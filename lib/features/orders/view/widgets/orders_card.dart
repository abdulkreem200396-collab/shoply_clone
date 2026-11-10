part of '../orders_screen.dart';

class _OrdersCard extends StatelessWidget {
  const _OrdersCard({required this.order});

  final ResponseOrder order;

  @override
  Widget build(BuildContext context) {
    final created = order.createdAt;
    final dateText = created == null
        ? 'just_now'.tr()
        : '${created.day}/${created.month}/${created.year}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          StatusChip(status: order.status),
          if (order.address.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'deliver_to'.tr(args: [order.address]),
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
          const SizedBox(height: 8),
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${item.quantity} × ${item.localizedName}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),
        ],
      ),
    );
  }
}
