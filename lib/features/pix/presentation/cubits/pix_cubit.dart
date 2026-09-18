import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/pix_repository.dart';
import 'pix_state.dart';

class PixCubit extends Cubit<PixState> {
  final PixRepository repository;

  PixCubit({required this.repository}) : super(const PixInitialState());

  Future<void> loadPixActions() async {
    emit(const PixLoadingState());
    final actions = await repository.getPixActions();
    emit(PixLoadedState(actions));
  }
}
