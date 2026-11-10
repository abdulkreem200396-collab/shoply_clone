import 'package:easy_localization/easy_localization.dart';

// بيحوّل كود الخطأ من Firebase لرسالة مفهومة ومترجمة
class ErrorHandleHelper {
  static String getCustomErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-credential':
      case 'wrong-password':
      case 'user-not-found':
        return 'incorrect_credentials'.tr();
      case 'email-already-in-use':
        return 'email_already_in_use'.tr();
      case 'weak-password':
        return 'weak_password'.tr();
      case 'invalid-email':
        return 'invalid_email'.tr();
      case 'user-disabled':
        return 'user_disabled'.tr();
      case 'too-many-requests':
        return 'too_many_requests'.tr();
      case 'requires-recent-login':
        return 'please_login_again'.tr();
      default:
        return 'something_went_wrong'.tr();
    }
  }
}
