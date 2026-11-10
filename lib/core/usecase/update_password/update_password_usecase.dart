import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoply_clone/core/helper/error_handle_helper.dart';
import 'package:shoply_clone/core/model/update_password/request_update_password.dart';

class UpdatePasswordUsecase {
  Future<Either<String, Unit>> updatePassword({
    required RequestUpdatePassword request,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email;
    if (user == null || email == null) {
      return Left('please_log_in'.tr());
    }

    // الخطوة 1: إعادة تأكيد الهوية بكلمة المرور الحالية
    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: request.currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return Left('incorrect_current_password'.tr());
      }
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }

    // الخطوة 2: تغيير كلمة المرور
    try {
      await user.updatePassword(request.newPassword);
      return Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(ErrorHandleHelper.getCustomErrorMessage(e.code));
    }
  }
}
