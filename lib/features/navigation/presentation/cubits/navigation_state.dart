import 'package:equatable/equatable.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/navigation_menu_entity.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object?> get props => [];
}

class NavigationInitialState extends NavigationState {
  const NavigationInitialState();
}

class NavigationLoadingState extends NavigationState {
  const NavigationLoadingState();
}

class NavigationSuccessState extends NavigationState {
  final List<NavigationMenuEntity> menus;
  final UserEntity user;
  final int currentIndex;

  const NavigationSuccessState({
    required this.menus,
    required this.user,
    required this.currentIndex,
  });

  @override
  List<Object?> get props => [menus, user, currentIndex];
}

class NavigationErrorState extends NavigationState {
  final String message;

  const NavigationErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
