import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(currentIndex: 0));

  void changeTab(int index) {
    if (state.currentIndex != index) {
      emit(NavigationState(currentIndex: index));
    }
  }
}
