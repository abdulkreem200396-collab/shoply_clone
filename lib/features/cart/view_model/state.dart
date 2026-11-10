import 'package:shoply_clone/core/model/cart/cart_item.dart';

abstract class CartState {}

class CartInitState extends CartState {}

class CartLoadedState extends CartState {
  CartLoadedState({required this.items});

  final List<CartItem> items;
}

class CartCheckoutLoadingState extends CartState {}

class CartCheckoutSuccessState extends CartState {}

class CartAddressMissingState extends CartState {}

class CartCheckoutErrorState extends CartState {
  CartCheckoutErrorState({required this.message});

  final String message;
}
