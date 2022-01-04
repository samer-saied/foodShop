import 'package:onlinefooddeliverysystem/models/cart_item_model.dart';

enum CartSteps {
  initialization,
  Preparing,
  Processing,
  Shipped,
  Delivered,
  refund
}

class CartModel {
  late final String cartID;
  late List<CartItemModel> cartItems;
  late String? shippingFees;
  late String? cartTotal;
  late String? promoCode;
  CartSteps? cartSteps = CartSteps.initialization;
  late DateTime? date = DateTime.now();

  CartModel({
    required this.cartID,
    required this.cartItems,
    this.shippingFees,
    this.cartTotal,
    this.promoCode,
    this.cartSteps,
    this.date,
  });

  CartModel.fromJson(
    Map<String, dynamic> json,
  ) {
    cartID = json['cartID'];
    shippingFees = json['shippingFees'];
    cartTotal = json['cartTotal'];
    promoCode = json['promoCode'];
    cartSteps =
        CartSteps.values.firstWhere((e) => (e.toString() == json['stateCart']));

    date = json['date'];

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
      "cartItems": cartItems.map((element) {
        return element.toJson();
      }).toList(),
      "shippingFees": shippingFees ?? '0',
      "cartTotal": cartTotal ?? '0',
      "promoCode": promoCode ?? '0',
      'stateCart': cartSteps.toString(),
    };
  }
}
