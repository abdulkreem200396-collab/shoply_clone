import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';
import 'package:shoply_clone/core/utils/theme/app_colors.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/error_view/error_view.dart';
import 'package:shoply_clone/core/utils/widgets/loading/custom_loading.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/core/utils/widgets/status_chip/status_chip.dart';
import 'package:shoply_clone/features/admin_orders/view_model/cubit.dart';
import 'package:shoply_clone/features/admin_orders/view_model/state.dart';

part 'widgets/admin_order_card.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminOrdersCubit()..load(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'all_orders'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocListener<AdminOrdersCubit, AdminOrdersState>(
          listener: (context, state) {
            if (state is AdminOrdersActionErrorState) {
              CustomSnackBar.show(context, state.message);
            }
          },
          child: BlocBuilder<AdminOrdersCubit, AdminOrdersState>(
            buildWhen: (previous, current) =>
                current is AdminOrdersLoadedState ||
                current is AdminOrdersLoadingState ||
                current is AdminOrdersErrorState,
            builder: (context, state) {
              if (state is AdminOrdersLoadedState) {
                if (state.orders.isEmpty) {
                  return EmptyScreen(
                    message: 'no_orders_yet'.tr(),
                    icon: Icons.receipt_long_outlined,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => context.read<AdminOrdersCubit>().load(),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.orders.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return _AdminOrderCard(order: state.orders[index]);
                    },
                  ),
                );
              }

              if (state is AdminOrdersErrorState) {
                return ErrorView(
                  message: state.message,
                  onRetry: () => context.read<AdminOrdersCubit>().load(),
                );
              }

              return const CustomLoading();
            },
          ),
        ),
      ),
    );
  }
}
