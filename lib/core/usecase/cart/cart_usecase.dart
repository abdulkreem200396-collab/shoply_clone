import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/model/cart/cart_item.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';

class CartUsecase {
  CollectionReference<Map<String, dynamic>>? get _ref {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');
  }

  Future<Either<String, List<CartItem>>> getCart() async {
    try {
      final ref = _ref;
      if (ref == null) return Right(<CartItem>[]);
      final snapshot = await ref.get();
      return Right(
        snapshot.docs.map((doc) {
          final data = doc.data();
          return CartItem(
            product: ProductModel.fromMap(doc.id, data),
            quantity: (data['quantity'] as num?)?.toInt() ?? 1,
          );
        }).toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> save(CartItem item) async {
    try {
      await _ref?.doc(item.product.id).set({
        ...item.product.toMap(),
        'quantity': item.quantity,
      });
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> delete(String productId) async {
    try {
      await _ref?.doc(productId).delete();
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
