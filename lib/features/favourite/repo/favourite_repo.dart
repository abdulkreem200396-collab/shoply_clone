import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/usecase/auth_status/auth_status_usecase.dart';
import 'package:shoply_clone/core/usecase/favourite/favourite_usecase.dart';

class FavouriteRepo {
  final _favouriteUsecase = FavouriteUsecase();
  final _authStatusUsecase = AuthStatusUsecase();

  Stream<bool> get loginChanges => _authStatusUsecase.loggedInChanges;

  Future<Either<String, List<ProductModel>>> getFavourites() {
    return _favouriteUsecase.getFavourites();
  }

  Future<Either<String, Unit>> add(ProductModel product) {
    return _favouriteUsecase.add(product);
  }

  Future<Either<String, Unit>> remove(ProductModel product) {
    return _favouriteUsecase.remove(product.id);
  }
}
