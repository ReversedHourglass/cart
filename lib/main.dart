import 'package:cart/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cart/core/features/catalog/data/datasources/catalog_remote_datasource.dart';
import 'package:cart/core/features/catalog/data/repositories/catalog_repository_impl.dart';
import 'package:cart/core/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:cart/core/features/catalog/presentation/pages/catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogBloc(
            repository: CatalogRepositoryImpl(
              remoteDataSource: CatalogRemoteDataSource(),
            ),
          )..add(
              CatalogRequestEvent(),
            ),
        ),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Cart Demo',
        home: CatalogPage(),
      ),
    );
  }
}
