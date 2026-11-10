import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/cart/cart_item.dart';
import 'package:shoply_clone/core/usecase/auth_status/auth_status_usecase.dart';
import 'package:shoply_clone/core/usecase/cart/cart_usecase.dart';
import 'package:shoply_clone/core/usecase/checkout/checkout_usecase.dart';

class CartRepo {
  final _cartUsecase = CartUsecase();
  final _checkoutUsecase = CheckoutUsecase();
  final _authStatusUsecase = AuthStatusUsecase();

  Stream<bool> get loginChanges => _authStatusUsecase.loggedInChanges;

  Future<Either<String, List<CartItem>>> getCart() => _cartUsecase.getCart();

  Future<Either<String, Unit>> save(CartItem item) => _cartUsecase.save(item);

  Future<Either<String, Unit>> delete(String productId) {
    return _cartUsecase.delete(productId);
  }

  Future<Either<String, String>> getAddress() => _checkoutUsecase.getAddress();

  Future<Either<String, Unit>> placeOrder({
    required List<CartItem> items,
    required double total,
    required String address,
  }) {
    return _checkoutUsecase.placeOrder(
      items: items,
      total: total,
      address: address,
    );
  }
}
