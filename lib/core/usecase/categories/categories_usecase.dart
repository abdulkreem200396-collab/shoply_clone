import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shoply_clone/core/model/categories/category_model.dart';

class CategoriesUsecase {
  static const _order = ['shoes', 'clothes', 'bags', 'accessories', 'beauty'];

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('categories')
          .get();
      final categories =
          snapshot.docs
              .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
              .toList()
            ..sort((a, b) {
              final ia = _order.indexOf(a.id);
              final ib = _order.indexOf(b.id);
              return (ia == -1 ? 999 : ia).compareTo(ib == -1 ? 999 : ib);
            });
      return Right(categories);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
