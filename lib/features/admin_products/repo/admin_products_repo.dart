import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/core/usecase/admin/admin_products_usecase.dart';
import 'package:shoply_clone/core/usecase/products/products_usecase.dart';

class AdminProductsRepo {
  final _productsUsecase = ProductsUsecase();
  final _adminProductsUsecase = AdminProductsUsecase();

  Future<Either<String, List<ProductModel>>> getProducts() {
    return _productsUsecase.getProducts();
  }

  Future<Either<String, Unit>> delete(String id) {
    return _adminProductsUsecase.deleteProduct(id);
  }
}
