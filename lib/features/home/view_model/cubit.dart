import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/home/repo/home_repo.dart';
import 'package:shoply_clone/features/home/view_model/state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitState());

  final _homeRepo = HomeRepo();
  String userName = '';

  Future<void> loadUser() async {
    final result = await _homeRepo.getUserName();
    if (isClosed) return;

    result.fold((_) {}, (name) {
      userName = name;
      emit(HomeUserLoadedState(userName: name));
    });
  }
}
