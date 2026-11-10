import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/helper/error_handle_helper.dart';
import 'package:shoply_clone/core/model/signup/request_signup.dart';
import 'package:shoply_clone/core/model/signup/response_signup.dart';

class SignupUsecase {
  Future<Either<String, ResponseSignup>> signup({
    required RequestSignup requestSignup,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: requestSignup.email,
            password: requestSignup.password,
          );

      final user = credential.user;
      if (user == null) {
        return Left('something_went_wrong'.tr());
      }

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'fullName': requestSignup.fullName,
        'username': requestSignup.username,
        'email': requestSignup.email,
        'address': requestSignup.address,
        if (requestSignup.photo != null) 'photo': Blob(requestSignup.photo!),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // فشل إرسال الإيميل مش سبب نفشّل التسجيل: شاشة التحقق فيها زر "إعادة الإرسال"
      try {
        await user.sendEmailVerification();
      } on FirebaseAuthException {
        // تجاهل
      }

      return Right(ResponseSignup(uid: user.uid, email: requestSignup.email));
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    } on FirebaseException catch (e) {
      return Left(e.message ?? 'something_went_wrong'.tr());
    }
  }
}
