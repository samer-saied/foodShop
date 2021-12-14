class CategoryModel {
  final String categoryId;
  final String imageUrl;
  final String title;
  final String description;

  CategoryModel({
    required this.categoryId,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  CategoryModel.fronJson(Map<String, dynamic> json)
      : categoryId = json['categoryId'],
        imageUrl = json['imageUrl'],
        title = json['title'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "imageUrl": imageUrl,
      "title": title,
      "description": description,
    };
  }
}
