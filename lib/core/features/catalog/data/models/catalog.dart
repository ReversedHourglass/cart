import 'package:cart/core/features/catalog/data/models/category.dart';
import 'package:cart/core/features/catalog/domain/entities/catalog.dart';
import 'package:equatable/equatable.dart';

class Catalog extends Equatable {
  final List<Category> categories;

  const Catalog({
    required this.categories,
  });

  factory Catalog.fromEntity(CatalogEntity entity) {
    return Catalog(
      categories: entity.categories.map((e) => Category.fromEntity(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [
        categories,
      ];
}
