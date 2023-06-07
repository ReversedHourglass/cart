import 'package:cart/core/features/catalog/data/datasources/catalog_datasource.dart';
import 'package:cart/core/features/catalog/data/models/catalog.dart';
import 'package:cart/core/features/catalog/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl extends CatalogRepository {
  final CatalogDataSource remoteDataSource;

  CatalogRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Catalog> getCatalog() async {
    final Catalog catalog = await remoteDataSource.getCatalog();

    return catalog;
  }
}
