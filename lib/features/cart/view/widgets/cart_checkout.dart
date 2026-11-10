part of '../cart_screen.dart';

class _CartCheckout extends StatelessWidget {
  const _CartCheckout();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total'.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cubit.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return CustomButton(
                text: 'checkout'.tr(),
                isLoading: state is CartCheckoutLoadingState,
                onPressed: cubit.checkout,
              );
            },
          ),
        ],
      ),
    );
  }
}
