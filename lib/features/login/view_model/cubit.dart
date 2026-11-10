import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/login/request_login.dart';
import 'package:shoply_clone/features/login/repo/login_repo.dart';
import 'package:shoply_clone/features/login/view_model/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitState());

  final _loginRepo = LoginRepo();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    // الفحص بيصير بالـ validators اللي بحقول الكتابة
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(LoginLoadingState());

    final result = await _loginRepo.login(
      requestLogin: RequestLogin(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );

    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(LoginErrorState(errorMessage: errorMessage)),
      (responseLogin) => emit(
        LoginSuccessState(isEmailVerified: responseLogin.isEmailVerified),
      ),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
