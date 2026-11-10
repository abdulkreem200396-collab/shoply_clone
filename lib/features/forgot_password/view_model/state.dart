abstract class ForgotPasswordState {}

class ForgotPasswordInitState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordErrorState extends ForgotPasswordState {
  ForgotPasswordErrorState({required this.errorMessage});

  final String errorMessage;
}

class ForgotPasswordSuccessState extends ForgotPasswordState {}
