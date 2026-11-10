import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/features/admin_products/repo/admin_products_repo.dart';
import 'package:shoply_clone/features/admin_products/view_model/state.dart';

class AdminProductsCubit extends Cubit<AdminProductsState> {
  AdminProductsCubit() : super(AdminProductsInitState());

  final _adminProductsRepo = AdminProductsRepo();
  List<ProductModel> products = [];

  Future<void> load() async {
    emit(AdminProductsLoadingState());

    final result = await _adminProductsRepo.getProducts();
    if (isClosed) return;

    result.fold((message) => emit(AdminProductsErrorState(message: message)), (
      data,
    ) {
      products = data;
      emit(AdminProductsLoadedState(products: products));
    });
  }

  Future<void> delete(ProductModel product) async {
    final result = await _adminProductsRepo.delete(product.id);
    if (isClosed) return;

    result.fold(
      (message) {
        emit(AdminProductsActionErrorState(message: message));
        emit(AdminProductsLoadedState(products: products));
      },
      (_) {
        products = products.where((p) => p.id != product.id).toList();
        emit(AdminProductsDeletedState());
        emit(AdminProductsLoadedState(products: products));
      },
    );
  }
}
