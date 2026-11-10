import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/model/order/response_order.dart';

class AdminOrdersUsecase {
  // collectionGroup: بيجيب كل مجلدات 'orders' من كل المستخدمين مرة وحدة
  Future<Either<String, List<ResponseOrder>>> getAllOrders() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collectionGroup('orders')
          .get();

      final now = DateTime.now();
      final orders =
          snapshot.docs
              .map(
                (doc) => ResponseOrder.fromMap(
                  doc.id,
                  doc.data(),
                  userId: doc.reference.parent.parent?.id,
                ),
              )
              .toList()
            ..sort(
              (a, b) => (b.createdAt ?? now).compareTo(a.createdAt ?? now),
            );

      return Right(orders);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> updateStatus({
    required String userId,
    required String orderId,
    required OrderStatus status,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({'status': status.name});
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
