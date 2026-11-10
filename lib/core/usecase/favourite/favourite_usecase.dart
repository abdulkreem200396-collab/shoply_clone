import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';

class FavouriteUsecase {
  CollectionReference<Map<String, dynamic>>? get _ref {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favourites');
  }

  Future<Either<String, List<ProductModel>>> getFavourites() async {
    try {
      final ref = _ref;
      if (ref == null) return Right(<ProductModel>[]);
      final snapshot = await ref.get();
      return Right(
        snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> add(ProductModel product) async {
    try {
      await _ref?.doc(product.id).set(product.toMap());
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> remove(String productId) async {
    try {
      await _ref?.doc(productId).delete();
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
