import 'package:easy_localization/easy_localization.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  final String id;
  final String name;
  final String image;

  factory CategoryModel.fromMap(String id, Map<String, dynamic> data) {
    return CategoryModel(
      id: id,
      name: data['name'] as String? ?? '',
      image: data['image'] as String? ?? '',
    );
  }

  // اسم الفئة مترجم إذا في مفتاح إله (cat_<id>)، وإلا بنستخدم الاسم من Firestore
  String get localizedName {
    final key = 'cat_$id';
    final translated = key.tr();
    return translated == key ? name : translated;
  }
}
