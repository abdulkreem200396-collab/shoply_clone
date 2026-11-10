import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shoply_clone/core/model/products/product_model.dart';

class ProductsUsecase {
  Future<Either<String, List<ProductModel>>> getProducts() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .get();
      return Right(
        snapshot.docs
            .map((doc) => ProductModel.fromMap(doc.id, doc.data()))
            .toList(),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
