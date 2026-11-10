abstract class VerifyEmailState {}

class VerifyEmailInitState extends VerifyEmailState {}

class VerifyEmailLoadingState extends VerifyEmailState {}

class VerifyEmailNotVerifiedState extends VerifyEmailState {}

class VerifyEmailVerifiedState extends VerifyEmailState {}

class VerifyEmailResentState extends VerifyEmailState {}

class VerifyEmailSignedOutState extends VerifyEmailState {}

class VerifyEmailErrorState extends VerifyEmailState {
  VerifyEmailErrorState({required this.message});

  final String message;
}
