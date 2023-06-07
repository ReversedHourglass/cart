import 'package:cart/core/features/catalog/data/datasources/catalog_datasource.dart';
import 'package:cart/core/features/catalog/data/models/catalog.dart';
import 'package:cart/core/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CatalogRepositoryImpl extends CatalogRepository {
  final CatalogDataSource remoteDataSource;
  final CatalogDataSource localDataSource;

  CatalogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Catalog> getCatalog() async {
    Catalog catalog;
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        catalog = await remoteDataSource.getCatalog();
      } catch (e) {
        catalog = await localDataSource.getCatalog();
      }
    } else {
      catalog = await localDataSource.getCatalog();
    }

    return catalog;
  }
}
