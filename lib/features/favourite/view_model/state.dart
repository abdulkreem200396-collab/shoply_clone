import 'package:shoply_clone/core/model/products/product_model.dart';

abstract class FavouriteState {}

class FavouriteInitState extends FavouriteState {}

class FavouriteLoadedState extends FavouriteState {
  FavouriteLoadedState({required this.products});

  final List<ProductModel> products;
}
