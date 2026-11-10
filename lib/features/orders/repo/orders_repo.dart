import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';
import 'package:shoply_clone/core/usecase/orders/orders_usecase.dart';

class OrdersRepo {
  final _ordersUsecase = OrdersUsecase();

  Future<Either<String, List<ResponseOrder>>> getOrders() {
    return _ordersUsecase.getOrders();
  }
}
