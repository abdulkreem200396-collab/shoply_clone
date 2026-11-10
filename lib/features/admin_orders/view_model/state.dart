import 'package:shoply_clone/core/model/order/response_order.dart';

abstract class AdminOrdersState {}

class AdminOrdersInitState extends AdminOrdersState {}

class AdminOrdersLoadingState extends AdminOrdersState {}

class AdminOrdersLoadedState extends AdminOrdersState {
  AdminOrdersLoadedState({required this.orders});

  final List<ResponseOrder> orders;
}

class AdminOrdersErrorState extends AdminOrdersState {
  AdminOrdersErrorState({required this.message});

  final String message;
}

class AdminOrdersActionErrorState extends AdminOrdersState {
  AdminOrdersActionErrorState({required this.message});

  final String message;
}

class AdminOrdersStatusUpdatedState extends AdminOrdersState {}
