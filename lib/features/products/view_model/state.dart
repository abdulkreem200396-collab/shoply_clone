import 'package:shoply_clone/core/model/products/product_model.dart';

abstract class ProductsState {}

class ProductsInitState extends ProductsState {}

class ProductsLoadingState extends ProductsState {}

class ProductsLoadedState extends ProductsState {
  ProductsLoadedState({required this.products});

  final List<ProductModel> products;
}

class ProductsErrorState extends ProductsState {
  ProductsErrorState({required this.message});

  final String message;
}
