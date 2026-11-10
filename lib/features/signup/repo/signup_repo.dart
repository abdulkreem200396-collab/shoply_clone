import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/signup/request_signup.dart';
import 'package:shoply_clone/core/model/signup/response_signup.dart';
import 'package:shoply_clone/core/usecase/signup/signup_usecase.dart';

class SignupRepo {
  final _signupUsecase = SignupUsecase();

  Future<Either<String, ResponseSignup>> signup({
    required RequestSignup requestSignup,
  }) async {
    return await _signupUsecase.signup(requestSignup: requestSignup);
  }
}
