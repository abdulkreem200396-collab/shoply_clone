import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/cart/cart_item.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/features/cart/repo/cart_repo.dart';
import 'package:shoply_clone/features/cart/view_model/state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitState()) {
    _authSub = _cartRepo.loginChanges.listen((loggedIn) {
      if (loggedIn) {
        load();
      } else {
        _items = [];
        emit(CartLoadedState(items: _items));
      }
    });
  }

  final _cartRepo = CartRepo();
  late final StreamSubscription<bool> _authSub;
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get total {
    double sum = 0;
    for (final item in _items) {
      sum += item.subtotal;
    }
    return sum;
  }

  Future<void> load() async {
    final result = await _cartRepo.getCart();
    if (isClosed) return;

    result.fold((_) {}, (items) {
      _items = items;
      emit(CartLoadedState(items: _items));
    });
  }

  void add(ProductModel product) {
    final index = _items.indexWhere((item) => item.product == product);
    final CartItem item;
    final list = [..._items];

    if (index == -1) {
      item = CartItem(product: product, quantity: 1);
      list.add(item);
    } else {
      item = CartItem(product: product, quantity: list[index].quantity + 1);
      list[index] = item;
    }

    _items = list;
    emit(CartLoadedState(items: _items));
    _cartRepo.save(item);
  }

  void decrease(ProductModel product) {
    final index = _items.indexWhere((item) => item.product == product);
    if (index == -1) return;

    final list = [..._items];
    if (list[index].quantity == 1) {
      list.removeAt(index);
      _items = list;
      emit(CartLoadedState(items: _items));
      _cartRepo.delete(product.id);
    } else {
      final item = CartItem(
        product: product,
        quantity: list[index].quantity - 1,
      );
      list[index] = item;
      _items = list;
      emit(CartLoadedState(items: _items));
      _cartRepo.save(item);
    }
  }

  Future<void> checkout() async {
    if (_items.isEmpty) return;

    emit(CartCheckoutLoadingState());

    final addressResult = await _cartRepo.getAddress();
    if (isClosed) return;

    await addressResult.fold<Future<void>>(
      (message) async {
        emit(CartCheckoutErrorState(message: message));
        emit(CartLoadedState(items: _items));
      },
      (address) async {
        if (address.isEmpty) {
          emit(CartAddressMissingState());
          emit(CartLoadedState(items: _items));
          return;
        }

        final orderResult = await _cartRepo.placeOrder(
          items: _items,
          total: total,
          address: address,
        );
        if (isClosed) return;

        orderResult.fold(
          (message) {
            emit(CartCheckoutErrorState(message: message));
            emit(CartLoadedState(items: _items));
          },
          (_) {
            _items = [];
            emit(CartCheckoutSuccessState());
            emit(CartLoadedState(items: _items));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
