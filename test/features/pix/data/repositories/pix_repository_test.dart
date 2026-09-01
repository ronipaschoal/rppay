import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/pix/data/repositories/pix_repository.dart';

void main() {
  group('PixRepositoryImpl', () {
    late PixRepositoryImpl repository;

    setUp(() {
      repository = PixRepositoryImpl();
    });

    test('getPixActions retorna as 4 ações Pix simuladas', () async {
      final actions = await repository.getPixActions();

      expect(actions, hasLength(4));
      expect(actions.map((a) => a.title), [
        'Transferir',
        'Pix Copia e Cola',
        'Ler QR Code',
        'Cobrar / Receber',
      ]);
    });

    test('a primeira ação é "Transferir" com o ícone correto', () async {
      final actions = await repository.getPixActions();
      final first = actions.first;

      expect(first.title, 'Transferir');
      expect(first.subtitle, 'Pague com chave Pix');
      expect(first.icon, Icons.send_rounded);
    });
  });
}
