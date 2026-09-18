import 'package:equatable/equatable.dart';
import '../../domain/entities/pix_action_entity.dart';

abstract class PixState extends Equatable {
  const PixState();

  @override
  List<Object?> get props => [];
}

class PixInitialState extends PixState {
  const PixInitialState();
}

class PixLoadingState extends PixState {
  const PixLoadingState();
}

class PixLoadedState extends PixState {
  final List<PixActionEntity> actions;

  const PixLoadedState(this.actions);

  @override
  List<Object?> get props => [actions];
}
