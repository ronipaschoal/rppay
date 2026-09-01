import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/home/data/models/home_data_model.dart';

void main() {
  group('HomeDataModel', () {
    const model = HomeDataModel(
      id: '1',
      title: 'Pix Recebido',
      description: 'Pagamento de Salário',
      amount: 5450.00,
      date: 'Hoje, 09:30',
      isIncome: true,
      category: 'Salário',
    );

    test('expõe os campos recebidos no construtor', () {
      expect(model.id, '1');
      expect(model.title, 'Pix Recebido');
      expect(model.description, 'Pagamento de Salário');
      expect(model.amount, 5450.00);
      expect(model.date, 'Hoje, 09:30');
      expect(model.isIncome, isTrue);
      expect(model.category, 'Salário');
    });

    test('duas instâncias com os mesmos valores são iguais (Equatable)', () {
      const other = HomeDataModel(
        id: '1',
        title: 'Pix Recebido',
        description: 'Pagamento de Salário',
        amount: 5450.00,
        date: 'Hoje, 09:30',
        isIncome: true,
        category: 'Salário',
      );

      expect(model, equals(other));
      expect(model.hashCode, equals(other.hashCode));
    });

    test('instâncias com valores diferentes não são iguais', () {
      const other = HomeDataModel(
        id: '2',
        title: 'Pix Recebido',
        description: 'Pagamento de Salário',
        amount: 5450.00,
        date: 'Hoje, 09:30',
        isIncome: true,
        category: 'Salário',
      );

      expect(model, isNot(equals(other)));
    });
  });
}
