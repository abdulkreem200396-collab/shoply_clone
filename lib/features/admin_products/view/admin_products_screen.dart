import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/features/admin_products/view_model/cubit.dart';
import 'package:shoply_clone/features/admin_products/view_model/state.dart';
import 'package:shoply_clone/features/products/view_model/cubit.dart';

part 'widgets/admin_product_tile.dart';

class AdminProductsScreen extends StatelessWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminProductsCubit()..load(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'manage_products'.tr(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _openForm(context),
              child: const Icon(Icons.add),
            ),
            body: BlocListener<AdminProductsCubit, AdminProductsState>(
              listener: (context, state) {
                if (state is AdminProductsActionErrorState) {
                  CustomSnackBar.show(context, state.message);
                } else if (state is AdminProductsDeletedState) {
                  CustomSnackBar.show(context, 'product_deleted'.tr());
                  // بنحدّث قائمة المتجر كمان (الـ Cubit المشترك)
                  context.read<ProductsCubit>().load();
                }
              },
              child: BlocBuilder<AdminProductsCubit, AdminProductsState>(
                buildWhen: (previous, current) =>
                    current is AdminProductsLoadedState ||
                    current is AdminProductsLoadingState ||
                    current is AdminProductsErrorState,
                builder: (context, state) {
                  if (state is AdminProductsLoadedState) {
                    if (state.products.isEmpty) {
                      return EmptyScreen(message: 'no_products_yet'.tr());
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
                      itemCount: state.products.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _AdminProductTile(
                          product: state.products[index],
                        );
                      },
                    );
                  }

                  if (state is AdminProductsErrorState) {
                    return ErrorView(
                      message: state.message,
                      onRetry: () => context.read<AdminProductsCubit>().load(),
                    );
                  }

                  return const CustomLoading();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// فتح نموذج الإضافة (product == null) أو التعديل
Future<void> _openForm(BuildContext context, {ProductModel? product}) async {
  final adminCubit = context.read<AdminProductsCubit>();
  final shopCubit = context.read<ProductsCubit>();

  final saved = await Navigator.pushNamed(
    context,
    AppPages.adminProductFormScreen,
    arguments: product,
  );

  if (saved == true) {
    adminCubit.load();
    shopCubit.load();
  }
}
