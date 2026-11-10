abstract class SignupState {}

class SignupInitState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupPhotoChangedState extends SignupState {}

class SignupErrorState extends SignupState {
  SignupErrorState({required this.errorMessage});

  final String errorMessage;
}

class SignupSuccessState extends SignupState {}
