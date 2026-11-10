import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { verified, unverified, loggedOut }

class AuthStatusUsecase {
  AuthStatus getStatus() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return AuthStatus.loggedOut;
    return user.emailVerified ? AuthStatus.verified : AuthStatus.unverified;
  }

  // true لما يدخل مستخدم، false لما يطلع
  Stream<bool> get loggedInChanges {
    return FirebaseAuth.instance.authStateChanges().map((user) => user != null);
  }
}
