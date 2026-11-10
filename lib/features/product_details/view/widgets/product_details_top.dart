part of '../product_details_screen.dart';

class _ProductDetailsTop extends StatelessWidget {
  const _ProductDetailsTop({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProductDetailsCubit>();
    final primary = Theme.of(context).colorScheme.primary;

    return Column(
      children: [
        Container(
          height: 320,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: product.images.isEmpty
              ? const Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                )
              : PageView.builder(
                  itemCount: product.images.length,
                  onPageChanged: cubit.changeImage,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomNetworkImage(
                        url: product.images[index],
                        iconSize: 60,
                      ),
                    );
                  },
                ),
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(product.images.length, (i) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cubit.imageIndex == i
                        ? primary
                        : Colors.grey.shade400,
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
