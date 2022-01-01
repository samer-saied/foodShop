import 'package:onlinefooddeliverysystem/models/product_model.dart';

class CartItemModel {
  final ProductModel product;
  final String quantity;
  final String total;

  CartItemModel({
    required this.product,
    required this.quantity,
    required this.total,
  });

  CartItemModel.fromJson(Map<String, dynamic> json)
      : product = ProductModel.fromJson(
            json['product'], json['product']['productId']),
        quantity = json['quantity'] ?? 1,
        total = json['total'];

  Map<String, dynamic> toJson() {
    return {
      "product": product,
      "quantity": quantity,
      "total": total,
    };
  }
}
