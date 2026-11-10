import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/orders/repo/orders_repo.dart';
import 'package:shoply_clone/features/orders/view_model/state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitState());

  final _ordersRepo = OrdersRepo();

  Future<void> load() async {
    emit(OrdersLoadingState());

    final result = await _ordersRepo.getOrders();
    if (isClosed) return;

    result.fold(
      (message) => emit(OrdersErrorState(message: message)),
      (orders) => emit(OrdersLoadedState(orders: orders)),
    );
  }
}
