import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/product_card/product_card.dart';
import 'package:shoply_clone/features/products/view_model/cubit.dart';
import 'package:shoply_clone/features/products/view_model/state.dart';

part 'widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.title, this.categoryId});

  final String title;
  final String? categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadedState) {
            final products = categoryId == null
                ? state.products
                : state.products
                      .where((p) => p.categoryId == categoryId)
                      .toList();

            if (products.isEmpty) {
              return EmptyScreen(message: 'no_products_here'.tr());
            }
            return _ProductsGrid(products: products);
          }

          if (state is ProductsErrorState) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<ProductsCubit>().load(),
            );
          }

          return const CustomLoading();
        },
      ),
    );
  }
}
