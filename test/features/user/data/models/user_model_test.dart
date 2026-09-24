import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/user/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    const json = {
      'name': 'Roni Paschoal',
      'agency': '0001',
      'account': '123456-7',
    };

    test('fromJson converte os campos', () {
      final model = UserModel.fromJson(json);

      expect(model.name, 'Roni Paschoal');
      expect(model.agency, '0001');
      expect(model.account, '123456-7');
    });

    test('toJson é o inverso de fromJson', () {
      expect(UserModel.fromJson(json).toJson(), json);
    });
  });
}
