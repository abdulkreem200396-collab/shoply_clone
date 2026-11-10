import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/helper/error_handle_helper.dart';

class VerifyEmailUsecase {
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';

  // reload() بتجيب أحدث بيانات من السيرفر، وبدونها emailVerified بتضل قديمة
  Future<Either<String, bool>> checkVerified() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final verified =
          FirebaseAuth.instance.currentUser?.emailVerified ?? false;
      return Right(verified);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }

  Future<Either<String, Unit>> resend() async {
    try {
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
