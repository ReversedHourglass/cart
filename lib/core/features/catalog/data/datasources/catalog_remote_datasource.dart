import 'dart:convert';
import 'dart:io';

import 'package:cart/core/features/catalog/domain/entities/catalog.dart';
import 'package:http/http.dart' as http;

import 'package:cart/core/features/catalog/data/datasources/catalog_datasource.dart';
import 'package:cart/core/features/catalog/data/models/catalog.dart';

class CatalogRemoteDataSource extends CatalogDataSource {
  CatalogRemoteDataSource();

  @override
  Future<Catalog> getCatalog() async {
    final response = await http.get(
      Uri.https(
          'api.digifood.fr',
          '/v1/catalogs/catalog_V3M2YWhXYjZ4YVUwbHh0QVRZU3hpdz09',
          {'lang': 'fr'}),
      headers: {
        HttpHeaders.authorizationHeader:
            'Bearer 454110|OwVvtY1VHZ0PaZtcN57kMddo7lwxJJUDUZnexDEj'
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Request to the digifood API failed.");
    }

    return Catalog.fromEntity(
        CatalogEntity.fromJson(jsonDecode(response.body)));
  }
}
