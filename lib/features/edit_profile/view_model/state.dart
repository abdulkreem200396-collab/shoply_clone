abstract class EditProfileState {}

class EditProfileInitState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileLoadedState extends EditProfileState {}

class EditProfilePhotoChangedState extends EditProfileState {}

class EditProfileSavingState extends EditProfileState {}

class EditProfileSavedState extends EditProfileState {}

class EditProfileErrorState extends EditProfileState {
  EditProfileErrorState({required this.message});

  final String message;
}
