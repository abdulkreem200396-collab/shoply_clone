import 'package:shoply_clone/core/model/order/response_order.dart';

abstract class OrdersState {}

class OrdersInitState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  OrdersLoadedState({required this.orders});

  final List<ResponseOrder> orders;
}

class OrdersErrorState extends OrdersState {
  OrdersErrorState({required this.message});

  final String message;
}
