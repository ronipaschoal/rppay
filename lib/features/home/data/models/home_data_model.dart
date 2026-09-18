import '../../domain/entities/home_data_entity.dart';

class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required super.id,
    required super.title,
    required super.description,
    required super.amount,
    required super.date,
    required super.isIncome,
    required super.category,
  });
}
