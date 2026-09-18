import 'package:equatable/equatable.dart';
import '../../domain/entities/home_data_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  final List<HomeDataEntity> items;

  const HomeSuccessState(this.items);

  @override
  List<Object?> get props => [items];
}

class HomeErrorState extends HomeState {
  final String message;

  const HomeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
