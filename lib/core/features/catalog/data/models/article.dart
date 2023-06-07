import 'package:cart/core/features/catalog/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String name;
  final String? description;
  final int price;
  final String imageUrl;

  const Article({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Article.fromEntity(ArticleEntity entity) {
    return Article(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      imageUrl: entity.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        imageUrl,
      ];
}
