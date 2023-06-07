import 'package:cart/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cart/core/features/catalog/data/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF122E36)),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  final Article article = state.articles.keys.elementAt(index);

                  return Column(
                    children: [
                      ListTile(
                        title: Text(article.name),
                        subtitle: Text(
                            "${(article.price / 100).toStringAsFixed(2)} €"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                      CartRemoveArticleEvent(
                                        article: article,
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(state.articles[article].toString()),
                            IconButton(
                              onPressed: () {
                                context.read<CartBloc>().add(
                                      CartAddArticleEvent(
                                        article: article,
                                      ),
                                    );
                              },
                              icon: const Icon(Icons.add),
                            ),
                            Text(
                              "${((article.price * state.articles[article]!) / 100).toStringAsFixed(2)} €",
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: const Text("Total"),
              trailing: Text(
                "${(state.total / 100).toStringAsFixed(2)} €",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
