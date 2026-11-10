import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/admin/repo/admin_repo.dart';
import 'package:shoply_clone/features/admin/view_model/state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitState());

  final _adminRepo = AdminRepo();

  Future<void> load() async {
    emit(AdminLoadingState());

    final isAdmin = await _adminRepo.isAdmin();
    if (isClosed) return;

    if (!isAdmin) {
      emit(AdminNoAccessState());
      return;
    }

    final result = await _adminRepo.getStats();
    if (isClosed) return;

    result.fold(
      (message) => emit(AdminErrorState(message: message)),
      (stats) => emit(AdminLoadedState(stats: stats)),
    );
  }
}
