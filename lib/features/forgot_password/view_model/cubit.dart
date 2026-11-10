import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/forgot_password/request_forgot_password.dart';
import 'package:shoply_clone/features/forgot_password/repo/forgot_password_repo.dart';
import 'package:shoply_clone/features/forgot_password/view_model/state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({String initialEmail = ''})
    : emailController = TextEditingController(text: initialEmail),
      super(ForgotPasswordInitState());

  final _forgotPasswordRepo = ForgotPasswordRepo();
  final TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  Future<void> send() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(ForgotPasswordLoadingState());

    final result = await _forgotPasswordRepo.forgotPassword(
      requestForgotPassword: RequestForgotPassword(
        email: emailController.text.trim(),
      ),
    );

    if (isClosed) return;

    result.fold(
      (errorMessage) =>
          emit(ForgotPasswordErrorState(errorMessage: errorMessage)),
      (_) => emit(ForgotPasswordSuccessState()),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
