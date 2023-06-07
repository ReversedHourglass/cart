import 'package:cart/core/features/catalog/data/models/article.dart';
import 'package:cart/core/features/catalog/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final List<Article> articles;

  const Category({
    required this.id,
    required this.name,
    required this.articles,
  });

  factory Category.fromEntity(CategoryEntity entity) {
    return Category(
      id: entity.id,
      name: entity.name,
      articles: entity.articles.map((e) => Article.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        articles,
      ];
}
