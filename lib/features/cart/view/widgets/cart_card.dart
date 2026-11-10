part of '../cart_screen.dart';

class _CartCard extends StatelessWidget {
  const _CartCard({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return ListTile(
      leading: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomNetworkImage(url: item.product.imageUrl, iconSize: 24),
      ),
      title: Text(
        item.product.localizedName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(item.product.priceText),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => cubit.decrease(item.product),
            icon: const Icon(Icons.remove_circle_outline),
          ),
          Text(
            '${item.quantity}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
            onPressed: () => cubit.add(item.product),
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
    );
  }
}
