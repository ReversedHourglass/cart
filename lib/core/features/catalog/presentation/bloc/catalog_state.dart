part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object> get props => [];
}

class CatalogUninitializedState extends CatalogState {}

class CatalogLoadingState extends CatalogState {}

class CatalogLoadedState extends CatalogState {
  final Catalog catalog;

  const CatalogLoadedState({required this.catalog});

  @override
  List<Object> get props => [catalog];
}
