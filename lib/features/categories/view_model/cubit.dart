import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/categories/repo/categories_repo.dart';
import 'package:shoply_clone/features/categories/view_model/state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitState());

  final _categoriesRepo = CategoriesRepo();

  Future<void> load() async {
    emit(CategoriesLoadingState());

    final result = await _categoriesRepo.getCategories();
    if (isClosed) return;

    result.fold(
      (message) => emit(CategoriesErrorState(message: message)),
      (categories) => emit(CategoriesLoadedState(categories: categories)),
    );
  }
}
