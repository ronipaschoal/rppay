import '../entities/pix_action_entity.dart';

abstract class PixRepository {
  Future<List<PixActionEntity>> getPixActions();
}
