abstract class LoginState {}

class LoginInitState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  LoginErrorState({required this.errorMessage});

  final String errorMessage;
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required this.isEmailVerified});

  final bool isEmailVerified;
}
