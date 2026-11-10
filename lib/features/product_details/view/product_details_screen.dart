import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/features/cart/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/cubit.dart';
import 'package:shoply_clone/features/favourite/view_model/state.dart';
import 'package:shoply_clone/features/product_details/view_model/cubit.dart';
import 'package:shoply_clone/features/product_details/view_model/state.dart';

part 'widgets/product_details_top.dart';
part 'widgets/product_details_bottom.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                final isFavourite = context.read<FavouriteCubit>().isFavourite(
                  product,
                );
                return IconButton(
                  onPressed: () {
                    context.read<FavouriteCubit>().toggle(product);
                  },
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: isFavourite ? Colors.red : null,
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _ProductDetailsTop(product: product),
            const SizedBox(height: 24),
            _ProductDetailsBottom(product: product),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(
              text: 'add_to_cart'.tr(),
              onPressed: () {
                context.read<CartCubit>().add(product);
                CustomSnackBar.show(
                  context,
                  'added_to_cart'.tr(args: [product.localizedName]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
