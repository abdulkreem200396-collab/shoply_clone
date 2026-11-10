import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shoply_clone/core/model/admin/request_admin_product.dart';

class AdminProductsUsecase {
  CollectionReference<Map<String, dynamic>> get _products {
    return FirebaseFirestore.instance.collection('products');
  }

  // id == null يعني منتج جديد، وإلا تعديل
  Future<Either<String, Unit>> saveProduct({
    String? id,
    required RequestAdminProduct request,
  }) async {
    try {
      if (id == null) {
        await _products.add(request.toMap());
      } else {
        await _products.doc(id).set(request.toMap(), SetOptions(merge: true));
      }
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> deleteProduct(String id) async {
    try {
      await _products.doc(id).delete();
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
