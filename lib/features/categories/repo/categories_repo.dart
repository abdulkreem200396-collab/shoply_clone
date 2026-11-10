import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/categories/category_model.dart';
import 'package:shoply_clone/core/usecase/categories/categories_usecase.dart';

class CategoriesRepo {
  final _categoriesUsecase = CategoriesUsecase();

  Future<Either<String, List<CategoryModel>>> getCategories() {
    return _categoriesUsecase.getCategories();
  }
}
