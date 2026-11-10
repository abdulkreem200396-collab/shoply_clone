import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/categories/category_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/core/utils/widgets/product_card/product_card.dart';
import 'package:shoply_clone/features/categories/view_model/cubit.dart';
import 'package:shoply_clone/features/categories/view_model/state.dart';
import 'package:shoply_clone/features/home/view_model/cubit.dart';
import 'package:shoply_clone/features/home/view_model/state.dart';
import 'package:shoply_clone/features/main/view_model/cubit.dart';
import 'package:shoply_clone/features/products/view_model/cubit.dart';
import 'package:shoply_clone/features/products/view_model/state.dart';

part 'widgets/home_banner.dart';
part 'widgets/home_categories.dart';
part 'widgets/home_trending_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<ProductsCubit>().load(),
          context.read<CategoriesCubit>().load(),
          context.read<HomeCubit>().loadUser(),
        ]);
      },
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: const [
          _HomeGreeting(),
          _HomeBanner(),
          SizedBox(height: 24),
          _HomeCategories(),
          SizedBox(height: 24),
          _HomeTrendingProducts(),
        ],
      ),
    );
  }
}

// عنوان القسم: اسم + زر View All
class _HomeSectionTitle extends StatelessWidget {
  const _HomeSectionTitle({required this.title, required this.onViewAll});

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: onViewAll, child: Text('view_all'.tr())),
      ],
    );
  }
}
