import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';
import 'package:shoply_clone/features/admin_orders/repo/admin_orders_repo.dart';
import 'package:shoply_clone/features/admin_orders/view_model/state.dart';

class AdminOrdersCubit extends Cubit<AdminOrdersState> {
  AdminOrdersCubit() : super(AdminOrdersInitState());

  final _adminOrdersRepo = AdminOrdersRepo();
  List<ResponseOrder> orders = [];

  Future<void> load() async {
    emit(AdminOrdersLoadingState());

    final result = await _adminOrdersRepo.getOrders();
    if (isClosed) return;

    result.fold((message) => emit(AdminOrdersErrorState(message: message)), (
      data,
    ) {
      orders = data;
      emit(AdminOrdersLoadedState(orders: orders));
    });
  }

  // منحدّث الشاشة فوراً، وإذا فشل الحفظ بنرجّع الحالة القديمة
  Future<void> updateStatus(ResponseOrder order, OrderStatus status) async {
    if (order.status == status) return;

    final previous = orders;
    orders = orders
        .map(
          (o) => o.id == order.id && o.userId == order.userId
              ? o.copyWith(status: status)
              : o,
        )
        .toList();
    emit(AdminOrdersLoadedState(orders: orders));

    final result = await _adminOrdersRepo.updateStatus(
      userId: order.userId,
      orderId: order.id,
      status: status,
    );
    if (isClosed) return;

    result.fold(
      (message) {
        orders = previous;
        emit(AdminOrdersActionErrorState(message: message));
        emit(AdminOrdersLoadedState(orders: orders));
      },
      (_) {
        emit(AdminOrdersStatusUpdatedState());
        emit(AdminOrdersLoadedState(orders: orders));
      },
    );
  }
}
