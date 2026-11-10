import 'package:shoply_clone/core/helper/translation_helper.dart';

class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.isTrending,
    required this.categoryId,
    this.nameAr = '',
    this.descriptionAr = '',
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final List<String> images;
  final bool isTrending;
  final String categoryId;
  final String nameAr;
  final String descriptionAr;

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'] as String? ?? '',
      description: data['description'] as String? ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0,
      images: List<String>.from(data['images'] as List? ?? []),
      isTrending: data['isTrending'] as bool? ?? false,
      categoryId: data['categoryId'] as String? ?? '',
      nameAr: data['nameAr'] as String? ?? '',
      descriptionAr: data['descriptionAr'] as String? ?? '',
    );
  }

  // بنستخدمها لنحفظ المنتج بالسلة والمفضلة
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'images': images,
      'isTrending': isTrending,
      'categoryId': categoryId,
      'nameAr': nameAr,
      'descriptionAr': descriptionAr,
    };
  }

  // بالعربي: الحقل العربي من Firestore، وإلا مفتاح الترجمة، وإلا الاسم الأصلي
  String get localizedName {
    if (!TranslationHelper.isArabic) return name;
    if (nameAr.isNotEmpty) return nameAr;
    return TranslationHelper.tryTranslate('product_$id', fallback: name);
  }

  String get localizedDescription {
    if (!TranslationHelper.isArabic) return description;
    if (descriptionAr.isNotEmpty) return descriptionAr;
    return TranslationHelper.tryTranslate(
      'product_desc_$id',
      fallback: description,
    );
  }

  String get imageUrl => images.isNotEmpty ? images.first : '';

  String get priceText => '\$${price.toStringAsFixed(2)}';

  @override
  bool operator ==(Object other) => other is ProductModel && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
