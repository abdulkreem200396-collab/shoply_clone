import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';

class OrdersUsecase {
  Future<Either<String, List<ResponseOrder>>> getOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left('please_log_in'.tr());

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('orders')
          .orderBy('createdAt', descending: true)
          .get();
      return Right(
        snapshot.docs
            .map((doc) => ResponseOrder.fromMap(doc.id, doc.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
