class CartItemModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productUrl;
  String quantity;
  String? total;

  CartItemModel(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productUrl,
      required this.quantity}) {
    this.total = _calculateTotalItem().toString();
  }

  CartItemModel.fromJson(
    Map<String, dynamic> json,
  )   : productId = json['productId'],
        productTitle = json['productTitle'],
        productPrice = json['productPrice'],
        productUrl = json['productUrl'],
        quantity = json['quantity'] ?? 1,
        total = json['total'];

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "productTitle": productTitle,
      "productPrice": productPrice,
      "productUrl": productUrl,
      "quantity": quantity,
      "total": _calculateTotalItem().toString(),
    };
  }

  _calculateTotalItem() {
    double price = double.tryParse(this.productPrice) ?? 0;
    double quantity = double.tryParse(this.quantity) ?? 1;
    return price * quantity;
  }
}
