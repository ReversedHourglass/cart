import 'package:bloc/bloc.dart';
import 'package:cart/core/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:equatable/equatable.dart';

import '../../catalog/data/models/catalog.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository repository;

  CatalogBloc({
    required this.repository,
  }) : super(CatalogUninitializedState()) {
    on<CatalogEvent>((event, emit) async {
      if (event is CatalogRequestEvent) {
        emit(CatalogLoadingState());
        emit(CatalogLoadedState(catalog: await repository.getCatalog()));
      }
    });
  }
}
