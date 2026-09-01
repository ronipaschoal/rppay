import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/home/data/repositories/home_repository.dart';

void main() {
  group('HomeRepositoryImpl', () {
    late HomeRepositoryImpl repository;

    setUp(() {
      repository = HomeRepositoryImpl();
    });

    test('fetchItems retorna uma lista não vazia de HomeDataModel', () async {
      final items = await repository.fetchItems();

      expect(items, isNotEmpty);
      expect(items.length, 11);
    });

    test('cada item retornado possui um id único', () async {
      final items = await repository.fetchItems();
      final ids = items.map((item) => item.id).toSet();

      expect(ids.length, items.length);
    });

    test('o primeiro item corresponde aos dados simulados esperados', () async {
      final items = await repository.fetchItems();
      final first = items.first;

      expect(first.id, '1');
      expect(first.title, 'Pix Recebido - Empresa X');
      expect(first.isIncome, isTrue);
      expect(first.amount, 5450.00);
    });
  });
}
