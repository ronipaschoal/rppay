import 'package:equatable/equatable.dart';

class HomeDataEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double amount;
  final String date;
  final bool isIncome;
  final String category;

  const HomeDataEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    required this.isIncome,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    amount,
    date,
    isIncome,
    category,
  ];
}
