import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoply_clone/core/helper/order_status.dart';
import 'package:shoply_clone/core/helper/translation_helper.dart';

class OrderItem {
  const OrderItem({
    required this.productId,
    required this.name,
    required this.nameAr,
    required this.quantity,
  });

  final String productId;
  final String name;
  final String nameAr;
  final int quantity;

  String get localizedName {
    if (!TranslationHelper.isArabic) return name;
    if (nameAr.isNotEmpty) return nameAr;
    return TranslationHelper.tryTranslate('product_$productId', fallback: name);
  }
}

class ResponseOrder {
  const ResponseOrder({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.total,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  final String id;
  final String userId;
  final String userName;
  final String userEmail;
  final double total;
  final String address;
  final OrderStatus status;
  final DateTime? createdAt;
  final List<OrderItem> items;

  // اسم العميل، وإذا ما في فالإيميل، وإذا ما في فالمعرّف
  String get customer {
    if (userName.isNotEmpty) return userName;
    if (userEmail.isNotEmpty) return userEmail;
    return userId;
  }

  ResponseOrder copyWith({OrderStatus? status}) {
    return ResponseOrder(
      id: id,
      userId: userId,
      userName: userName,
      userEmail: userEmail,
      total: total,
      address: address,
      status: status ?? this.status,
      createdAt: createdAt,
      items: items,
    );
  }

  factory ResponseOrder.fromMap(
    String id,
    Map<String, dynamic> data, {
    String? userId,
  }) {
    final rawItems = List<Map<String, dynamic>>.from(
      data['items'] as List? ?? [],
    );

    return ResponseOrder(
      id: id,
      userId: userId ?? (data['userId'] as String? ?? ''),
      userName: data['userName'] as String? ?? '',
      userEmail: data['userEmail'] as String? ?? '',
      total: (data['total'] as num?)?.toDouble() ?? 0,
      address: data['address'] as String? ?? '',
      status: OrderStatus.parse(data['status'] as String?),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      items: rawItems
          .map(
            (item) => OrderItem(
              productId: item['productId'] as String? ?? '',
              name: item['name'] as String? ?? '',
              nameAr: item['nameAr'] as String? ?? '',
              quantity: (item['quantity'] as num?)?.toInt() ?? 1,
            ),
          )
          .toList(),
    );
  }
}
