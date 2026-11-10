import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/features/favourite/repo/favourite_repo.dart';
import 'package:shoply_clone/features/favourite/view_model/state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitState()) {
    _authSub = _favouriteRepo.loginChanges.listen((loggedIn) {
      if (loggedIn) {
        load();
      } else {
        _items = [];
        emit(FavouriteLoadedState(products: _items));
      }
    });
  }

  final _favouriteRepo = FavouriteRepo();
  late final StreamSubscription<bool> _authSub;
  List<ProductModel> _items = [];

  List<ProductModel> get items => _items;

  bool isFavourite(ProductModel product) => _items.contains(product);

  Future<void> load() async {
    final result = await _favouriteRepo.getFavourites();
    if (isClosed) return;

    result.fold((_) {}, (products) {
      _items = products;
      emit(FavouriteLoadedState(products: _items));
    });
  }

  // منحدّث الشاشة فوراً، وإذا فشل الحفظ بنرجّع القائمة القديمة
  Future<void> toggle(ProductModel product) async {
    final previous = [..._items];
    final wasFavourite = _items.contains(product);

    _items = wasFavourite
        ? _items.where((item) => item != product).toList()
        : [..._items, product];
    emit(FavouriteLoadedState(products: _items));

    final result = wasFavourite
        ? await _favouriteRepo.remove(product)
        : await _favouriteRepo.add(product);
    if (isClosed) return;

    result.fold((_) {
      _items = previous;
      emit(FavouriteLoadedState(products: _items));
    }, (_) {});
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
