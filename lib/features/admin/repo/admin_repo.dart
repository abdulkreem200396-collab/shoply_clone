import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/model/admin/admin_stats.dart';
import 'package:shoply_clone/core/usecase/admin/admin_access_usecase.dart';
import 'package:shoply_clone/core/usecase/admin/admin_orders_usecase.dart';
import 'package:shoply_clone/core/usecase/products/products_usecase.dart';

class AdminRepo {
  final _adminAccessUsecase = AdminAccessUsecase();
  final _productsUsecase = ProductsUsecase();
  final _ordersUsecase = AdminOrdersUsecase();

  Future<bool> isAdmin() => _adminAccessUsecase.isAdmin();

  Future<Either<String, AdminStats>> getStats() async {
    final productsResult = await _productsUsecase.getProducts();
    final ordersResult = await _ordersUsecase.getAllOrders();

    return productsResult.fold<Either<String, AdminStats>>(
      (message) => Left(message),
      (products) => ordersResult.fold<Either<String, AdminStats>>(
        (message) => Left(message),
        (orders) {
          final active = orders.where((o) => o.status != OrderStatus.cancelled);
          return Right(
            AdminStats(
              productsCount: products.length,
              ordersCount: orders.length,
              pendingCount: orders
                  .where((o) => o.status == OrderStatus.pending)
                  .length,
              revenue: active.fold<double>(0, (sum, o) => sum + o.total),
            ),
          );
        },
      ),
    );
  }
}
