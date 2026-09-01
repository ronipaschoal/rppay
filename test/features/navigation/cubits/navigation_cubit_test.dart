import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/navigation/cubits/navigation_cubit.dart';
import 'package:rppay/features/navigation/cubits/navigation_state.dart';

void main() {
  group('NavigationCubit', () {
    test('estado inicial é currentIndex 0', () {
      final cubit = NavigationCubit();
      expect(cubit.state, const NavigationState(currentIndex: 0));
      cubit.close();
    });

    blocTest<NavigationCubit, NavigationState>(
      'changeTab emite um novo estado quando o índice muda',
      build: () => NavigationCubit(),
      act: (cubit) => cubit.changeTab(1),
      expect: () => [const NavigationState(currentIndex: 1)],
    );

    blocTest<NavigationCubit, NavigationState>(
      'changeTab não emite nada quando o índice é igual ao atual',
      build: () => NavigationCubit(),
      act: (cubit) => cubit.changeTab(0),
      expect: () => <NavigationState>[],
    );
  });
}
