import 'package:shoply_clone/core/local/local_storage.dart';

class LocalStorageDependency {
  static Future<void> initLocalStorageDependency() async {
    await LocalStorage.instance.init();
  }
}
