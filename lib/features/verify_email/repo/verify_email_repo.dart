import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/usecase/verify_email/verify_email_usecase.dart';

class VerifyEmailRepo {
  final _verifyEmailUsecase = VerifyEmailUsecase();

  String get email => _verifyEmailUsecase.email;

  Future<Either<String, bool>> checkVerified() {
    return _verifyEmailUsecase.checkVerified();
  }

  Future<Either<String, Unit>> resend() {
    return _verifyEmailUsecase.resend();
  }

  Future<void> signOut() {
    return _verifyEmailUsecase.signOut();
  }
}
