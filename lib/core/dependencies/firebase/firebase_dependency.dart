import 'package:firebase_core/firebase_core.dart';
import 'package:shoply_clone/firebase_options.dart';

class FirebaseDependency {
  static Future<void> initFirebaseDependency() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
