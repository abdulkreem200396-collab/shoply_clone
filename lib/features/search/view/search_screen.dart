import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/product_card/product_card.dart';
import 'package:shoply_clone/features/products/view_model/cubit.dart';
import 'package:shoply_clone/features/products/view_model/state.dart';
import 'package:shoply_clone/features/search/view_model/cubit.dart';
import 'package:shoply_clone/features/search/view_model/state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SearchCubit>();

          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 72,
              title: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return TextField(
                    controller: cubit.searchController,
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    onChanged: cubit.updateQuery,
                    decoration: InputDecoration(
                      hintText: 'search_products'.tr(),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: cubit.query.isEmpty
                          ? null
                          : IconButton(
                              onPressed: cubit.clear,
                              icon: const Icon(Icons.close),
                            ),
                    ),
                  );
                },
              ),
            ),
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, searchState) {
                return BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    if (state is ProductsLoadedState) {
                      if (cubit.query.isEmpty) {
                        return EmptyScreen(
                          message: 'type_to_search'.tr(),
                          icon: Icons.search,
                        );
                      }

                      final results = cubit.filter(state.products);
                      if (results.isEmpty) {
                        return EmptyScreen(
                          message: 'no_results_for'.tr(args: [cubit.query]),
                          icon: Icons.search_off,
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: results.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        itemBuilder: (context, index) {
                          return ProductCard(product: results[index]);
                        },
                      );
                    }

                    if (state is ProductsErrorState) {
                      return ErrorView(
                        message: state.message,
                        onRetry: () => context.read<ProductsCubit>().load(),
                      );
                    }

                    return const CustomLoading();
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
