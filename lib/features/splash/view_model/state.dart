abstract class SplashState {}

class SplashInitState extends SplashState {}

class SplashNavigateState extends SplashState {
  SplashNavigateState({required this.route});

  final String route;
}
