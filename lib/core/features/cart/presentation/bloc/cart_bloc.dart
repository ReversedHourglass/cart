import 'package:bloc/bloc.dart';
import 'package:cart/core/features/catalog/data/models/article.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(const CartState(
          articles: {},
          total: 0,
        )) {
    on<CartEvent>((event, emit) {
      if (event is CartAddArticleEvent) {
        // copy of the map
        final articles =
            state.articles.map((key, value) => MapEntry(key, value));
        final article = event.article;

        if (articles.containsKey(article)) {
          articles[article] = articles[article]! + 1;
        } else {
          articles[article] = 1;
        }

        emit(state.copyWith(
          articles: articles,
          total: state.total + article.price,
        ));
      }

      if (event is CartRemoveArticleEvent) {
        // copy of the map
        final articles =
            state.articles.map((key, value) => MapEntry(key, value));
        final article = event.article;

        if (articles.containsKey(article)) {
          if (articles[article] == 1) {
            articles.remove(article);
          } else {
            articles[article] = articles[article]! - 1;
          }
        }

        emit(state.copyWith(
          articles: articles,
          total: state.total - article.price,
        ));
      }
    });
  }
}
