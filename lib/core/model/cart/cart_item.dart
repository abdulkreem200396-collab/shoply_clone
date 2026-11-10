import 'package:shoply_clone/core/model/products/product_model.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;

  double get subtotal => product.price * quantity;
}
