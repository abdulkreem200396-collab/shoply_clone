import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/model/profile/request_update_profile.dart';
import 'package:shoply_clone/core/model/profile/response_profile.dart';
import 'package:shoply_clone/core/usecase/admin/admin_access_usecase.dart';

class ProfileUsecase {
  final _adminAccessUsecase = AdminAccessUsecase();

  Future<Either<String, ResponseProfile>> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left('please_log_in'.tr());

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final isAdmin = await _adminAccessUsecase.isAdmin();

      return Right(
        ResponseProfile.fromMap(
          uid: user.uid,
          email: user.email ?? '',
          data: doc.data() ?? {},
          isAdmin: isAdmin,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }

  Future<Either<String, Unit>> updateProfile({
    required RequestUpdateProfile request,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return Left('please_log_in'.tr());

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': request.fullName,
        'username': request.username,
        'address': request.address,
        'email': user.email,
        if (request.photo != null) 'photo': Blob(request.photo!),
      }, SetOptions(merge: true));
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
