import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/user/data/repositories/user_repository_impl.dart';

void main() {
  group('UserRepositoryImpl', () {
    test('getUser retorna o usuário simulado da API', () async {
      final user = await UserRepositoryImpl().getUser();

      expect(user.name, 'Roni Paschoal');
      expect(user.firstName, 'Roni');
      expect(user.agency, '0001');
      expect(user.account, '123456-7');
    });
  });
}
