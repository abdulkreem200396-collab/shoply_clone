part of '../home_screen.dart';

class _HomeTrendingProducts extends StatelessWidget {
  const _HomeTrendingProducts();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeSectionTitle(
          title: 'trending_products'.tr(),
          onViewAll: () {
            Navigator.pushNamed(
              context,
              AppPages.productsScreen,
              arguments: {'title': 'all_products'.tr(), 'categoryId': null},
            );
          },
        ),
        const SizedBox(height: 12),
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoadedState) {
              final trending = state.products
                  .where((p) => p.isTrending)
                  .toList();

              if (trending.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: EmptyScreen(message: 'no_products_yet'.tr()),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trending.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: trending[index]);
                },
              );
            }

            if (state is ProductsErrorState) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: ErrorView(
                  message: state.message,
                  onRetry: () => context.read<ProductsCubit>().load(),
                ),
              );
            }

            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CustomLoading(),
            );
          },
        ),
      ],
    );
  }
}
