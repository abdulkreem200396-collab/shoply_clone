abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeUserLoadedState extends HomeState {
  HomeUserLoadedState({required this.userName});

  final String userName;
}
