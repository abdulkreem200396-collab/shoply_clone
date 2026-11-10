import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/features/cart/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/state.dart';

// كرت منتج: صورة مع قلب + اسم + سعر + زر إضافة للسلة
class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPages.productDetailsScreen,
          arguments: product,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CustomNetworkImage(url: product.imageUrl),
                    ),
                  ),
                  PositionedDirectional(
                    top: 0,
                    end: 0,
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        final isFavourite = context
                            .read<FavouriteCubit>()
                            .isFavourite(product);
                        return IconButton(
                          onPressed: () {
                            context.read<FavouriteCubit>().toggle(product);
                          },
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavourite ? Colors.red : Colors.black54,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.localizedName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      product.priceText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                onPressed: () {
                  context.read<CartCubit>().add(product);
                  CustomSnackBar.show(
                    context,
                    'added_to_cart'.tr(args: [product.localizedName]),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
