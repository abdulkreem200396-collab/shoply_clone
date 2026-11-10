class RequestAdminProduct {
  const RequestAdminProduct({
    required this.name,
    required this.nameAr,
    required this.description,
    required this.descriptionAr,
    required this.price,
    required this.images,
    required this.categoryId,
    required this.isTrending,
  });

  final String name;
  final String nameAr;
  final String description;
  final String descriptionAr;
  final double price;
  final List<String> images;
  final String categoryId;
  final bool isTrending;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nameAr': nameAr,
      'description': description,
      'descriptionAr': descriptionAr,
      'price': price,
      'images': images,
      'categoryId': categoryId,
      'isTrending': isTrending,
    };
  }
}
