part of '../home_screen.dart';

class _HomeCategories extends StatelessWidget {
  const _HomeCategories();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HomeSectionTitle(
          title: 'categories'.tr(),
          onViewAll: () => context.read<MainCubit>().changeTab(1),
        ),
        const SizedBox(height: 12),
        BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoadedState) {
              return SizedBox(
                height: 110,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return _HomeCategoryItem(category: state.categories[index]);
                  },
                ),
              );
            }

            if (state is CategoriesErrorState) {
              return SizedBox(
                height: 110,
                child: ErrorView(
                  message: state.message,
                  onRetry: () => context.read<CategoriesCubit>().load(),
                ),
              );
            }

            return const SizedBox(height: 110, child: CustomLoading());
          },
        ),
      ],
    );
  }
}

class _HomeCategoryItem extends StatelessWidget {
  const _HomeCategoryItem({required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppPages.productsScreen,
          arguments: {
            'title': category.localizedName,
            'categoryId': category.id,
          },
        );
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: CustomNetworkImage(url: category.image, iconSize: 28),
          ),
          const SizedBox(height: 8),
          Text(category.localizedName, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
