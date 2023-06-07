import 'dart:convert';
import 'package:cart/core/features/catalog/domain/entities/catalog.dart';

import 'package:cart/core/features/catalog/data/datasources/catalog_datasource.dart';
import 'package:cart/core/features/catalog/data/models/catalog.dart';
import 'package:flutter/services.dart';

class CatalogLocalDataSource extends CatalogDataSource {
  CatalogLocalDataSource();

  @override
  Future<Catalog> getCatalog() async {
    final String response = await rootBundle.loadString('res/local_data.json');

    return Catalog.fromEntity(CatalogEntity.fromJson(jsonDecode(response)));
  }
}
