import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/pix/cubits/pix_cubit.dart';
import 'package:rppay/features/pix/cubits/pix_state.dart';
import 'package:rppay/features/pix/data/models/pix_action_model.dart';
import 'package:rppay/features/pix/data/repositories/pix_repository.dart';

class _FakePixRepository implements PixRepository {
  _FakePixRepository({this.actions, this.error});

  final List<PixActionModel>? actions;
  final Object? error;

  @override
  Future<List<PixActionModel>> getPixActions() async {
    if (error != null) throw error!;
    return actions ?? const [];
  }
}

void main() {
  const action = PixActionModel(
    title: 'Transferir',
    subtitle: 'Pague com chave Pix',
    icon: Icons.send_rounded,
  );

  group('PixCubit', () {
    test('estado inicial é PixInitialState', () {
      final cubit = PixCubit(repository: _FakePixRepository());
      expect(cubit.state, const PixInitialState());
      cubit.close();
    });

    blocTest<PixCubit, PixState>(
      'emite [Loading, Loaded] quando o repositório retorna ações com sucesso',
      build: () => PixCubit(
        repository: _FakePixRepository(actions: const [action]),
      ),
      act: (cubit) => cubit.loadPixActions(),
      expect: () => [
        const PixLoadingState(),
        const PixLoadedState([action]),
      ],
    );

    blocTest<PixCubit, PixState>(
      'permanece em Loading e propaga o erro quando o repositório falha',
      build: () => PixCubit(
        repository: _FakePixRepository(error: Exception('falha de rede')),
      ),
      act: (cubit) => cubit.loadPixActions(),
      expect: () => [const PixLoadingState()],
      errors: () => [isA<Exception>()],
    );
  });
}
