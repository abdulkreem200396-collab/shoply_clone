import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/products/repo/products_repo.dart';
import 'package:shoply_clone/features/products/view_model/state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitState());

  final _productsRepo = ProductsRepo();

  Future<void> load() async {
    emit(ProductsLoadingState());

    final result = await _productsRepo.getProducts();
    if (isClosed) return;

    result.fold(
      (message) => emit(ProductsErrorState(message: message)),
      (products) => emit(ProductsLoadedState(products: products)),
    );
  }
}
