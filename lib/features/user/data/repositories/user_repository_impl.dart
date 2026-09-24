import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity> getUser() async {
    // Simula a chamada à API (ex.: GET /me).
    await Future.delayed(const Duration(milliseconds: 300));
    const response = {
      'name': 'Roni Paschoal',
      'agency': '0001',
      'account': '123456-7',
    };
    return UserModel.fromJson(response);
  }
}
