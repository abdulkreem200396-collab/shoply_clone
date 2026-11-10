import 'package:flutter/material.dart';
import 'package:shoply_clone/core/dependencies/easy_localization/easy_localization_dependency.dart';
import 'package:shoply_clone/core/dependencies/firebase/firebase_dependency.dart';
import 'package:shoply_clone/core/dependencies/local_storage/local_storage_dependency.dart';

// كل التجهيزات اللي بتصير قبل ما يشتغل التطبيق، بمكان واحد وبترتيب واضح
class MainDependency {
  static Future<void> mainInitDependency() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageDependency.initLocalStorageDependency();
    await FirebaseDependency.initFirebaseDependency();
    await EasyLocalizationDependency.initEasyLocalizationDependency();
  }
}
