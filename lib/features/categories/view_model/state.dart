import 'package:shoply_clone/core/model/categories/category_model.dart';

abstract class CategoriesState {}

class CategoriesInitState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  CategoriesLoadedState({required this.categories});

  final List<CategoryModel> categories;
}

class CategoriesErrorState extends CategoriesState {
  CategoriesErrorState({required this.message});

  final String message;
}
