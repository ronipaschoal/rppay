import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rppay/features/splash/cubits/splash_cubit.dart';
import 'package:rppay/features/splash/cubits/splash_state.dart';

void main() {
  group('SplashCubit', () {
    test('estado inicial é SplashLoadingState', () {
      final cubit = SplashCubit();
      expect(cubit.state, const SplashLoadingState());
      cubit.close();
    });

    blocTest<SplashCubit, SplashState>(
      'initApp emite SplashCompletedState após o delay inicial',
      build: () => SplashCubit(),
      act: (cubit) => cubit.initApp(),
      wait: const Duration(seconds: 2),
      expect: () => [const SplashCompletedState()],
    );
  });
}
