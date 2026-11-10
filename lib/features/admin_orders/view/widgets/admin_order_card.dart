part of '../admin_orders_screen.dart';

Future<void> _changeStatus(BuildContext context, ResponseOrder order) async {
  final selected = await showModalBottomSheet<OrderStatus>(
    context: context,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'change_status'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            for (final status in OrderStatus.values)
              ListTile(
                leading: Icon(Icons.circle, size: 14, color: status.color),
                title: Text(status.label),
                trailing: status == order.status
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.pop(sheetContext, status),
              ),
          ],
        ),
      );
    },
  );

  if (selected != null && context.mounted) {
    context.read<AdminOrdersCubit>().updateStatus(order, selected);
  }
}

class _AdminOrderCard extends StatelessWidget {
  const _AdminOrderCard({required this.order});

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
          Text(
            '${'customer'.tr()}: ${order.customer}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          if (order.userEmail.isNotEmpty && order.userName.isNotEmpty)
            Text(
              order.userEmail,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          if (order.address.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'deliver_to'.tr(args: [order.address]),
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),
          const SizedBox(height: 8),
          for (final item in order.items)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '${item.quantity} × ${item.localizedName}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatusChip(status: order.status),
              TextButton.icon(
                onPressed: () => _changeStatus(context, order),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: Text('change_status'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
