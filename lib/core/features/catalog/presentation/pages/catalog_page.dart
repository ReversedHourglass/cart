import 'package:cart/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cart/core/features/cart/presentation/pages/cart_page.dart';
import 'package:cart/core/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CatalogPage extends StatelessWidget {
  CatalogPage({Key? key}) : super(key: key);

  final ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(builder: (context, state) {
      if (state is CatalogLoadedState) {
        return DefaultTabController(
          length: state.catalog.categories.length,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartPage()));
                  },
                  icon: const Icon(Icons.shopping_cart),
                ),
              ],
              backgroundColor: const Color(0xFF122E36),
              bottom: TabBar(
                  onTap: (index) {
                    itemScrollController.scrollTo(
                        index: index,
                        duration: const Duration(milliseconds: 250));
                  },
                  isScrollable: true,
                  tabs: state.catalog.categories
                      .map((category) => SizedBox(
                            height: 30,
                            child: Text(category.name.toUpperCase()),
                          ))
                      .toList()),
            ),
            body: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemCount: state.catalog.categories.length,
              itemBuilder: (context, index) {
                final category = state.catalog.categories[index];

                return Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              category.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: category.articles.length,
                      itemBuilder: (context, index) {
                        final article = category.articles[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: SizedBox(
                            child: BlocBuilder<CartBloc, CartState>(builder: (
                              context,
                              state,
                            ) {
                              final int quantity = state.articles[article] ?? 0;

                              return Stack(children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 100,
                                  ),
                                  child: Card(
                                    elevation: 2,
                                    shape: ShapeBorder.lerp(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                        ),
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.5),
                                        ),
                                        1)!,
                                    child: ListTile(
                                      leading: Image.network(
                                        article.imageUrl,
                                        width: 50,
                                        height: 50,
                                      ),
                                      title: Text(article.name),
                                      subtitle: article.description != null
                                          ? Text(article.description!)
                                          : null,
                                      trailing: Text(
                                          "${(article.price / 100).toStringAsFixed(2)} €"),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                CartRemoveArticleEvent(
                                                    article: article));
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                        Text(quantity.toString()),
                                        IconButton(
                                          onPressed: () {
                                            context.read<CartBloc>().add(
                                                CartAddArticleEvent(
                                                    article: article));
                                          },
                                          icon: const Icon(Icons.add),
                                        ),
                                      ],
                                    )),
                              ]);
                            }),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
