import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/helper/error_handle_helper.dart';
import 'package:shoply_clone/core/model/forgot_password/request_forgot_password.dart';

class ForgotPasswordUsecase {
  Future<Either<String, Unit>> forgotPassword({
    required RequestForgotPassword requestForgotPassword,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: requestForgotPassword.email,
      );
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
