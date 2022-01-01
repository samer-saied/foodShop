import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';

class CartModel {
  late String cartID;
  late List<CartItemModel> cartItems;
  late double shippingFees;
  late double cartTotal;
  late double promoCode;

  CartModel({
    required this.cartID,
    required this.cartItems,
    required this.shippingFees,
    required this.cartTotal,
    required this.promoCode,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    cartID = json['cartID'];
    shippingFees = double.parse(json['shippingFees']);
    cartTotal = double.parse(json['cartTotal']);
    promoCode = double.parse(json['promoCode']);

    if (json['cartItems'] != null) {
      List<CartItemModel> items = [];
      json['cartItems'].forEach((item) {
        items.add(CartItemModel.fromJson(item));
      });
      cartItems = items;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "cartID": cartID,
      "cartItems": cartItems,
      "shippingFees": shippingFees,
      "cartTotal": cartTotal,
      "promoCode": promoCode,
    };
  }
}
