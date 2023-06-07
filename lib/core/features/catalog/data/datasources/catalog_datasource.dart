import 'package:cart/core/features/catalog/data/models/catalog.dart';

abstract class CatalogDataSource {
  Future<Catalog> getCatalog();
}
