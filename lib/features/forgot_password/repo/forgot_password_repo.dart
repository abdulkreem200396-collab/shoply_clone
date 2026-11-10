import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/forgot_password/request_forgot_password.dart';
import 'package:shoply_clone/core/usecase/forgot_password/forgot_password_usecase.dart';

class ForgotPasswordRepo {
  final _forgotPasswordUsecase = ForgotPasswordUsecase();

  Future<Either<String, Unit>> forgotPassword({
    required RequestForgotPassword requestForgotPassword,
  }) async {
    return await _forgotPasswordUsecase.forgotPassword(
      requestForgotPassword: requestForgotPassword,
    );
  }
}
