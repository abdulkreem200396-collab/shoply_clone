import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';
import 'package:shoply_clone/features/search/view_model/state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitState());

  final searchController = TextEditingController();
  String query = '';

  void updateQuery(String value) {
    query = value.trim();
    emit(SearchQueryChangedState());
  }

  void clear() {
    searchController.clear();
    updateQuery('');
  }

  // بنبحث بالاسم الأصلي وبالاسم المترجم
  List<ProductModel> filter(List<ProductModel> all) {
    final q = query.toLowerCase();
    return all
        .where(
          (p) =>
              p.name.toLowerCase().contains(q) ||
              p.localizedName.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
