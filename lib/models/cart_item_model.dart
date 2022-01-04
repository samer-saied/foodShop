class CartItemModel {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productUrl;
  String productSize;
  String quantity;
  String? total;

  CartItemModel(
      {required this.productId,
      required this.productTitle,
      required this.productPrice,
      required this.productUrl,
      required this.productSize,
      required this.quantity}) {
    this.total = _calculateTotalItem().toString();
  }

  CartItemModel.fromJson(
    Map<String, dynamic> json,
  )   : productId = json['productId'],
        productTitle = json['productTitle'],
        productPrice = json['productPrice'],
        productUrl = json['productUrl'],
        productSize = json['productSize'],
        quantity = json['quantity'] ?? 1,
        total = json['total'];

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "productTitle": productTitle,
      "productPrice": productPrice,
      "productUrl": productUrl,
      "quantity": quantity,
      "productSize": productSize,
      "total": _calculateTotalItem().toString(),
    };
  }

  _calculateTotalItem() {
    double price = double.tryParse(this.productPrice) ?? 0;
    double quantity = double.tryParse(this.quantity) ?? 1;
    return price * quantity;
  }
}
