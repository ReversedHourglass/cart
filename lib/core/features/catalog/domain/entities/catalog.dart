import 'package:cart/core/features/catalog/domain/entities/category.dart';

class CatalogEntity {
  List<CategoryEntity> categories;

  CatalogEntity({
    required this.categories,
  });

  factory CatalogEntity.fromJson(Map<String, dynamic> json) {
    return CatalogEntity(
      categories:
          List<CategoryEntity>.from(json['data']['categories'].where((json) {
        if (json['name'] == "Formules") {
          return false;
        }
        return true;
      }).map((json) => CategoryEntity.fromJSON(json))),
    );
  }
}
