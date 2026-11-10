import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/main/view_model/state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitState());

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(MainTabChangedState(index: index));
  }
}
