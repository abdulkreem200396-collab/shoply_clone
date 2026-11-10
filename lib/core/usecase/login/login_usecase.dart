import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/helper/error_handle_helper.dart';
import 'package:shoply_clone/core/model/login/request_login.dart';
import 'package:shoply_clone/core/model/login/response_login.dart';

class LoginUsecase {
  // Left = رسالة خطأ، Right = النتيجة
  Future<Either<String, ResponseLogin>> login({
    required RequestLogin requestLogin,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: requestLogin.email,
        password: requestLogin.password,
      );

      final user = credential.user;
      if (user == null) {
        return Left('something_went_wrong'.tr());
      }

      return Right(
        ResponseLogin(
          uid: user.uid,
          email: user.email ?? '',
          isEmailVerified: user.emailVerified,
        ),
      );
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
