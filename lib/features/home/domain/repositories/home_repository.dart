import '../entities/home_data_entity.dart';

abstract class HomeRepository {
  Future<List<HomeDataEntity>> fetchItems();
}
