import 'package:cart/core/features/catalog/data/models/catalog.dart';

abstract class CatalogRepository {
  Future<Catalog> getCatalog();
}
