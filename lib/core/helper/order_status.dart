import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum OrderStatus {
  pending(Colors.orange),
  processing(Colors.blue),
  shipped(Colors.purple),
  delivered(Colors.green),
  cancelled(Colors.red);

  const OrderStatus(this.color);

  final Color color;

  String get label => 'status_$name'.tr();

  static OrderStatus parse(String? value) {
    return OrderStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => OrderStatus.pending,
    );
  }
}
