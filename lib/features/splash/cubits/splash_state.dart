import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashLoadingState extends SplashState {
  const SplashLoadingState();
}

class SplashCompletedState extends SplashState {
  const SplashCompletedState();
}
