abstract class MainState {}

class MainInitState extends MainState {}

class MainTabChangedState extends MainState {
  MainTabChangedState({required this.index});

  final int index;
}
