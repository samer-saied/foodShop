class ProductModel {
  final String productId;
  final String imageUrl;
  final String title;
  final String description;
  final String categoryId;
  final Map<String, dynamic> currentPrice;
  final Map<String, dynamic> prePrice;
  final String status;
  final String available;

  ProductModel({
    required this.productId,
    required this.categoryId,
    required this.currentPrice,
    required this.prePrice,
    required this.status,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.available,
  });

  ProductModel.fromJson(Map<String, dynamic> json, productId)
      : productId = productId,
        categoryId = json['categoryId'],
        prePrice = json['prePrice'] ?? {},
        currentPrice = json['currentPrice'],
        status = json['status'] ?? 'normal',
        imageUrl = json['imageUrl'],
        title = json['title'],
        description = json['description'],
        available = json['available'] ?? 'In Stock';

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "categoryId": categoryId,
      "prePrice": prePrice,
      "currentPrice": currentPrice,
      "status": status,
      "imageUrl": imageUrl,
      "title": title,
      "description": description,
      "available": available,
    };
  }
}
