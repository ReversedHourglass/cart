import 'package:bloc_test/bloc_test.dart';
import 'package:cart/core/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cart/core/features/catalog/data/models/article.dart';
import 'package:cart/core/features/catalog/data/models/category.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartBloc bloc;
  late Category category;

  setUp(() {
    bloc = CartBloc();

    category = const Category(
      id: 'dummy',
      name: 'dummy',
      articles: [
        Article(
          id: 'dummy',
          name: 'dummy',
          price: 102,
          imageUrl: 'dummy',
        ),
        Article(
          id: 'dummy1',
          name: 'dummy1',
          price: 200,
          imageUrl: 'dummy1',
        ),
        Article(
          id: 'dummy2',
          name: 'dummy2',
          price: 350,
          imageUrl: 'dummy2',
        ),
        Article(
          id: 'dummy3',
          name: 'dummy3',
          price: 120,
          imageUrl: 'dummy3',
        ),
      ],
    );
  });

  test('initial state should be empty', () {
    expect(
        bloc.state,
        const CartState(
          articles: {},
          total: 0,
        ));
  });

  group('cart bloc manage cart', () {
    blocTest(
      'emits new state with new cart map and total price when article is added',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(CartAddArticleEvent(article: category.articles[0])),
      expect: () => [
        CartState(
          articles: {
            category.articles[0]: 1,
          },
          total: category.articles[0].price,
        ),
      ],
    );

    blocTest(
      'emits new state with new cart map and total price when article is added twice',
      build: () => bloc,
      act: (bloc) {
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
      },
      expect: () => [
        CartState(
          articles: {
            category.articles[0]: 1,
          },
          total: category.articles[0].price,
        ),
        CartState(
          articles: {
            category.articles[0]: 2,
          },
          total: category.articles[0].price * 2,
        ),
      ],
    );

    blocTest(
      'emits new state with new cart map and total price when article is added with mixed articles',
      build: () => bloc,
      act: (bloc) {
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartAddArticleEvent(article: category.articles[1]));
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartAddArticleEvent(article: category.articles[1]));
        bloc.add(CartAddArticleEvent(article: category.articles[1]));
        bloc.add(CartAddArticleEvent(article: category.articles[1]));
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
      },
      expect: () => [
        CartState(
          articles: {
            category.articles[0]: 1,
          },
          total: category.articles[0].price,
        ),
        CartState(
          articles: {
            category.articles[0]: 1,
            category.articles[1]: 1,
          },
          total: category.articles[0].price + category.articles[1].price,
        ),
        CartState(
          articles: {
            category.articles[0]: 2,
            category.articles[1]: 1,
          },
          total: category.articles[0].price * 2 + category.articles[1].price,
        ),
        CartState(
          articles: {
            category.articles[0]: 2,
            category.articles[1]: 2,
          },
          total:
              category.articles[0].price * 2 + category.articles[1].price * 2,
        ),
        CartState(
          articles: {
            category.articles[0]: 2,
            category.articles[1]: 3,
          },
          total:
              category.articles[0].price * 2 + category.articles[1].price * 3,
        ),
        CartState(
          articles: {
            category.articles[0]: 2,
            category.articles[1]: 4,
          },
          total:
              category.articles[0].price * 2 + category.articles[1].price * 4,
        ),
        CartState(
          articles: {
            category.articles[0]: 3,
            category.articles[1]: 4,
          },
          total:
              category.articles[0].price * 3 + category.articles[1].price * 4,
        ),
        CartState(
          articles: {
            category.articles[0]: 4,
            category.articles[1]: 4,
          },
          total:
              category.articles[0].price * 4 + category.articles[1].price * 4,
        ),
      ],
    );

    blocTest(
      'emits empty state when trying to remove an article that is not in the cart',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(CartRemoveArticleEvent(article: category.articles[0])),
      expect: () => [
        const CartState(
          articles: {},
          total: 0,
        ),
      ],
    );

    blocTest(
      'same state as beforewhen trying to remove an article that is not in the cart',
      build: () => bloc,
      act: (bloc) {
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartRemoveArticleEvent(article: category.articles[1]));
      },
      expect: () => [
        CartState(
          articles: {
            category.articles[0]: 1,
          },
          total: category.articles[0].price,
        ),
      ],
    );

    blocTest(
      'same state as before when trying to remove an article that is not in the cart, even if called multiple times',
      build: () => bloc,
      act: (bloc) {
        bloc.add(CartAddArticleEvent(article: category.articles[0]));
        bloc.add(CartRemoveArticleEvent(article: category.articles[1]));
        bloc.add(CartRemoveArticleEvent(article: category.articles[1]));
        bloc.add(CartRemoveArticleEvent(article: category.articles[1]));
      },
      expect: () => [
        CartState(
          articles: {
            category.articles[0]: 1,
          },
          total: category.articles[0].price,
        ),
      ],
    );
  });
}
