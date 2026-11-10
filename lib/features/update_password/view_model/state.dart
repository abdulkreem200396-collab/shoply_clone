abstract class UpdatePasswordState {}

class UpdatePasswordInitState extends UpdatePasswordState {}

class UpdatePasswordLoadingState extends UpdatePasswordState {}

class UpdatePasswordErrorState extends UpdatePasswordState {
  UpdatePasswordErrorState({required this.message});

  final String message;
}

class UpdatePasswordSuccessState extends UpdatePasswordState {}
