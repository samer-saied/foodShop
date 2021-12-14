class BannerModel {
  final String bannerId;
  final String imageUrl;
  final String referId;
  final String title;
  final String description;
  int? priority;

  BannerModel({
    required this.bannerId,
    required this.imageUrl,
    required this.referId,
    required this.title,
    required this.description,
    this.priority,
  });

  BannerModel.fronJson(Map<String, dynamic> json)
      : bannerId = json['bannerId'],
        imageUrl = json['imageUrl'],
        referId = json['referId'],
        title = json['title'],
        description = json['description'],
        priority = json['priority'] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "bannerId": bannerId,
      "imageUrl": imageUrl,
      "referId": referId,
      "title": title,
      "description": description,
      "priority": priority,
    };
  }
}
