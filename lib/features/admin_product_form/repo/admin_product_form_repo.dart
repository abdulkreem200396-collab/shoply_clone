import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/admin/request_admin_product.dart';
import 'package:shoply_clone/core/usecase/admin/admin_products_usecase.dart';

class AdminProductFormRepo {
  final _adminProductsUsecase = AdminProductsUsecase();

  Future<Either<String, Unit>> save({
    String? id,
    required RequestAdminProduct request,
  }) {
    return _adminProductsUsecase.saveProduct(id: id, request: request);
  }
}
