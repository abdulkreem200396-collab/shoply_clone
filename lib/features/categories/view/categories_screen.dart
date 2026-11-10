import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/categories/category_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/features/categories/view_model/cubit.dart';
import 'package:shoply_clone/features/categories/view_model/state.dart';

part 'widgets/categories_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadedState) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return _CategoriesCard(category: state.categories[index]);
            },
          );
        }

        if (state is CategoriesErrorState) {
          return ErrorView(
            message: state.message,
            onRetry: () => context.read<CategoriesCubit>().load(),
          );
        }

        return const CustomLoading();
      },
    );
  }
}
