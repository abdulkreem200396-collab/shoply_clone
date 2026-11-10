import 'package:shoply_clone/core/model/products/product_model.dart';

abstract class AdminProductsState {}

class AdminProductsInitState extends AdminProductsState {}

class AdminProductsLoadingState extends AdminProductsState {}

class AdminProductsLoadedState extends AdminProductsState {
  AdminProductsLoadedState({required this.products});

  final List<ProductModel> products;
}

class AdminProductsErrorState extends AdminProductsState {
  AdminProductsErrorState({required this.message});

  final String message;
}

class AdminProductsActionErrorState extends AdminProductsState {
  AdminProductsActionErrorState({required this.message});

  final String message;
}

class AdminProductsDeletedState extends AdminProductsState {}
