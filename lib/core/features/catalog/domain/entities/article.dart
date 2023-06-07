class ArticleEntity {
  String id;
  String name;
  String? description;
  int price;
  String imageUrl;

  ArticleEntity({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ArticleEntity.fromJSON(Map<String, dynamic> json) {
    return ArticleEntity(
      id: json['article']['did'],
      name: json['article']['name'],
      description: json['article']['description'],
      price: json['article']['price_advertised'],
      imageUrl: json['article']['background_web']['file']['url'],
    );
  }
}
