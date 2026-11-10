import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/features/orders/view_model/cubit.dart';
import 'package:shoply_clone/features/orders/view_model/state.dart';
import 'package:shoply_clone/core/utils/widgets/status_chip/status_chip.dart';
part 'widgets/orders_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'my_orders'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoadedState) {
              if (state.orders.isEmpty) {
                return EmptyScreen(
                  message: 'no_orders_yet'.tr(),
                  icon: Icons.receipt_long_outlined,
                );
              }

              return RefreshIndicator(
                onRefresh: () => context.read<OrdersCubit>().load(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.orders.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _OrdersCard(order: state.orders[index]);
                  },
                ),
              );
            }

            if (state is OrdersErrorState) {
              return ErrorView(
                message: state.message,
                onRetry: () => context.read<OrdersCubit>().load(),
              );
            }

            return const CustomLoading();
          },
        ),
      ),
    );
  }
}
