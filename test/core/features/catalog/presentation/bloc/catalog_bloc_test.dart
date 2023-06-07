import 'package:bloc_test/bloc_test.dart';
import 'package:cart/core/features/catalog/data/models/catalog.dart';
import 'package:cart/core/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:cart/core/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCatalogRepository extends Mock implements CatalogRepository {}

void main() {
  late CatalogBloc bloc;
  late MockCatalogRepository mockedCatalogRepository;
  late Catalog catalog;

  setUp(() {
    mockedCatalogRepository = MockCatalogRepository();

    bloc = CatalogBloc(
      repository: mockedCatalogRepository,
    );

    catalog = const Catalog(categories: []);
  });

  test('initial state should be empty', () {
    expect(bloc.state, CatalogUninitializedState());
  });

  group('catalog bloc get catalog', () {
    blocTest(
      setUp: () {
        when(() => mockedCatalogRepository.getCatalog())
            .thenAnswer((_) async => catalog);
      },
      'emits CatalogLoadedState when Catalog has been requested successfully',
      build: () => bloc,
      act: (bloc) => bloc.add(CatalogRequestEvent()),
      expect: () => [
        CatalogLoadingState(),
        CatalogLoadedState(catalog: catalog),
      ],
    );

    blocTest(
      setUp: () {
        when(() => mockedCatalogRepository.getCatalog())
            .thenAnswer((_) async => catalog);
      },
      'should call getCatalog method from repository',
      build: () => bloc,
      act: (bloc) => bloc.add(CatalogRequestEvent()),
      expect: () => [
        CatalogLoadingState(),
        CatalogLoadedState(catalog: catalog),
      ],
      verify: (_) {
        verify(() => mockedCatalogRepository.getCatalog()).called(1);
      },
    );
  });
}
