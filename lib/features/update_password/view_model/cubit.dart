import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/update_password/request_update_password.dart';
import 'package:shoply_clone/features/update_password/repo/update_password_repo.dart';
import 'package:shoply_clone/features/update_password/view_model/state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitState());

  final _updatePasswordRepo = UpdatePasswordRepo();
  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> update() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(UpdatePasswordLoadingState());

    final result = await _updatePasswordRepo.updatePassword(
      request: RequestUpdatePassword(
        currentPassword: currentController.text,
        newPassword: newController.text,
      ),
    );
    if (isClosed) return;

    result.fold(
      (message) => emit(UpdatePasswordErrorState(message: message)),
      (_) => emit(UpdatePasswordSuccessState()),
    );
  }

  @override
  Future<void> close() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
