import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/cart/cart_item.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_clone/core/utils/widgets/empty_screen/empty_screen.dart';
import 'package:shoply_clone/core/utils/widgets/network_image/custom_network_image.dart';
import 'package:shoply_clone/core/utils/widgets/snack_bar/custom_snack_bar.dart';
import 'package:shoply_clone/features/cart/view_model/cubit.dart';
import 'package:shoply_clone/features/cart/view_model/state.dart';

part 'widgets/cart_card.dart';
part 'widgets/cart_checkout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartCheckoutSuccessState) {
          CustomSnackBar.show(context, 'order_placed'.tr());
        } else if (state is CartCheckoutErrorState) {
          CustomSnackBar.show(context, state.message);
        } else if (state is CartAddressMissingState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('add_address_first'.tr()),
              action: SnackBarAction(
                label: 'add'.tr(),
                onPressed: () {
                  Navigator.pushNamed(context, AppPages.editProfileScreen);
                },
              ),
            ),
          );
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => current is CartLoadedState,
        builder: (context, state) {
          final items = context.read<CartCubit>().items;

          if (items.isEmpty) {
            return EmptyScreen(
              message: 'cart_empty'.tr(),
              icon: Icons.shopping_cart_outlined,
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return _CartCard(item: items[index]);
                  },
                ),
              ),
              const _CartCheckout(),
            ],
          );
        },
      ),
    );
  }
}
