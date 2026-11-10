import 'package:firebase_auth/firebase_auth.dart';

class LogoutUsecase {
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
