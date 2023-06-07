part of 'cart_bloc.dart';

class CartState extends Equatable {
  final Map<Article, int> articles;
  final double total;

  const CartState({
    required this.articles,
    required this.total,
  });

  CartState copyWith({
    Map<Article, int>? articles,
    double? total,
  }) {
    return CartState(
      articles: articles ?? this.articles,
      total: total ?? this.total,
    );
  }

  @override
  List<Object> get props => [articles];
}
