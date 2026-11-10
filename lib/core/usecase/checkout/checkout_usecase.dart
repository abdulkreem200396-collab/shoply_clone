import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/model/cart/cart_item.dart';

class CheckoutUsecase {
  Future<Either<String, String>> getAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left('please_log_in'.tr());

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return Right((doc.data()?['address'] as String? ?? '').trim());
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  // الطلب وتفريغ السلة بعملية وحدة: كلها أو ولا شي
  Future<Either<String, Unit>> placeOrder({
    required List<CartItem> items,
    required double total,
    required String address,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left('please_log_in'.tr());

    try {
      final db = FirebaseFirestore.instance;
      final userRef = db.collection('users').doc(user.uid);

      final userDoc = await userRef.get();
      final userName = userDoc.data()?['fullName'] as String? ?? '';

      final batch = db.batch();

      batch.set(userRef.collection('orders').doc(), {
        'userId': user.uid,
        'userName': userName,
        'userEmail': user.email ?? '',
        'status': 'pending',
        'items': items
            .map(
              (item) => {
                'productId': item.product.id,
                'name': item.product.name,
                'nameAr': item.product.nameAr,
                'price': item.product.price,
                'quantity': item.quantity,
                'image': item.product.imageUrl,
              },
            )
            .toList(),
        'total': total,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });

      for (final item in items) {
        batch.delete(userRef.collection('cart').doc(item.product.id));
      }

      await batch.commit();
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
