import 'package:cart/core/features/presentation/bloc/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<CatalogBloc, CatalogState>(builder: (context, state) {
      if (state is CatalogLoadedState) {
        return ListView.builder(
          itemCount: state.catalog.categories.length,
          itemBuilder: (context, index) {
            final category = state.catalog.categories[index];
            return ExpansionTile(
              title: Text(category.name),
              children: category.articles
                  .map((article) => ListTile(
                        title: Text(article.name),
                        subtitle: article.description != null
                            ? Text(article.description!)
                            : null,
                        trailing: Text("${article.price} €"),
                      ))
                  .toList(),
            );
          },
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}
