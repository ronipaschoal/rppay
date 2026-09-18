import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  HomeCubit({required this.repository}) : super(const HomeInitialState());

  Future<void> loadData() async {
    emit(const HomeLoadingState());
    try {
      final items = await repository.fetchItems();
      emit(HomeSuccessState(items));
    } catch (e) {
      emit(HomeErrorState('Erro ao carregar dados: ${e.toString()}'));
    }
  }
}
