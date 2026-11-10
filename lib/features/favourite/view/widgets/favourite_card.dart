part of '../favourite_screen.dart';

class _FavouriteCard extends StatelessWidget {
  const _FavouriteCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPages.productDetailsScreen,
          arguments: product,
        );
      },
      leading: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomNetworkImage(url: product.imageUrl, iconSize: 24),
      ),
      title: Text(
        product.localizedName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(product.priceText),
      trailing: IconButton(
        onPressed: () => context.read<FavouriteCubit>().toggle(product),
        icon: const Icon(Icons.favorite, color: Colors.red),
      ),
    );
  }
}
