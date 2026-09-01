import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/home/cubits/home_cubit.dart';
import 'package:rppay/features/home/cubits/home_state.dart';
import 'package:rppay/features/home/data/models/home_data_model.dart';
import 'package:rppay/features/home/data/repositories/home_repository.dart';

class _FakeHomeRepository implements HomeRepository {
  _FakeHomeRepository({this.items, this.error});

  final List<HomeDataModel>? items;
  final Object? error;

  @override
  Future<List<HomeDataModel>> fetchItems() async {
    if (error != null) throw error!;
    return items ?? const [];
  }
}

void main() {
  const item = HomeDataModel(
    id: '1',
    title: 'Pix Recebido',
    description: 'Pagamento de Salário',
    amount: 100.0,
    date: 'Hoje',
    isIncome: true,
    category: 'Salário',
  );

  group('HomeCubit', () {
    test('estado inicial é HomeInitialState', () {
      final cubit = HomeCubit(repository: _FakeHomeRepository());
      expect(cubit.state, const HomeInitialState());
      cubit.close();
    });

    blocTest<HomeCubit, HomeState>(
      'emite [Loading, Success] quando o repositório retorna dados com sucesso',
      build: () => HomeCubit(
        repository: _FakeHomeRepository(items: const [item]),
      ),
      act: (cubit) => cubit.loadData(),
      expect: () => [
        const HomeLoadingState(),
        const HomeSuccessState([item]),
      ],
    );

    blocTest<HomeCubit, HomeState>(
      'emite [Loading, Error] quando o repositório lança uma exceção',
      build: () => HomeCubit(
        repository: _FakeHomeRepository(error: Exception('falha de rede')),
      ),
      act: (cubit) => cubit.loadData(),
      expect: () => [
        const HomeLoadingState(),
        isA<HomeErrorState>().having(
          (state) => state.message,
          'message',
          contains('falha de rede'),
        ),
      ],
    );
  });
}
