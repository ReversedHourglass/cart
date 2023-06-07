import 'package:cart/core/features/catalog/data/datasources/catalog_remote_datasource.dart';
import 'package:cart/core/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:cart/core/features/presentation/bloc/catalog_bloc.dart';
import 'package:cart/core/features/presentation/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CatalogBloc(
          repository: CatalogRepositoryImpl(
            remoteDataSource: CatalogRemoteDataSource(),
          ),
        )..add(
            CatalogRequestEvent(),
          ),
        child: const CatalogPage(),
      ),
    );
  }
}
