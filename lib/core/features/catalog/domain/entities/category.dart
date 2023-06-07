import 'package:cart/core/features/catalog/domain/entities/article.dart';

class CategoryEntity {
  String id;
  String name;
  List<ArticleEntity> articles;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.articles,
  });

  factory CategoryEntity.fromJSON(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['did'],
      name: json['name'],
      articles: (json['entries'] as List)
          .map((article) => ArticleEntity.fromJSON(article))
          .toList(),
    );
  }
}
