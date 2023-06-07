part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartAddArticleEvent extends CartEvent {
  final Article article;

  const CartAddArticleEvent({required this.article});

  @override
  List<Object> get props => [article];
}

class CartRemoveArticleEvent extends CartEvent {
  final Article article;

  const CartRemoveArticleEvent({required this.article});

  @override
  List<Object> get props => [article];
}
