import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';
import 'package:shoply_clone/core/usecase/admin/admin_orders_usecase.dart';

class AdminOrdersRepo {
  final _adminOrdersUsecase = AdminOrdersUsecase();

  Future<Either<String, List<ResponseOrder>>> getOrders() {
    return _adminOrdersUsecase.getAllOrders();
  }

  Future<Either<String, Unit>> updateStatus({
    required String userId,
    required String orderId,
    required OrderStatus status,
  }) {
    return _adminOrdersUsecase.updateStatus(
      userId: userId,
      orderId: orderId,
      status: status,
    );
  }
}
