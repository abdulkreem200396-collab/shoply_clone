import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/usecase/products/products_usecase.dart';

class ProductsRepo {
  final _productsUsecase = ProductsUsecase();

  Future<Either<String, List<ProductModel>>> getProducts() {
    return _productsUsecase.getProducts();
  }
}
