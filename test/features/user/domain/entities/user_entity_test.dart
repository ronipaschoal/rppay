import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/user/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('firstName retorna o primeiro nome, ignorando espaços extras', () {
      const user = UserEntity(
        name: '  Maria   da Silva ',
        agency: '0001',
        account: '123456-7',
      );

      expect(user.firstName, 'Maria');
    });
  });
}
