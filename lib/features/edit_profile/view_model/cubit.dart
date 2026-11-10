import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/profile/request_update_profile.dart';
import 'package:shoply_clone/features/edit_profile/repo/edit_profile_repo.dart';
import 'package:shoply_clone/features/edit_profile/view_model/state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitState());

  final _editProfileRepo = EditProfileRepo();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final addressController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Uint8List? photoBytes;
  bool _photoChanged = false;

  Future<void> load() async {
    emit(EditProfileLoadingState());

    final result = await _editProfileRepo.getProfile();
    if (isClosed) return;

    result.fold((message) => emit(EditProfileErrorState(message: message)), (
      profile,
    ) {
      nameController.text = profile.fullName;
      usernameController.text = profile.username;
      addressController.text = profile.address;
      photoBytes = profile.photo;
      emit(EditProfileLoadedState());
    });
  }

  void setPhoto(Uint8List bytes) {
    photoBytes = bytes;
    _photoChanged = true;
    emit(EditProfilePhotoChangedState());
  }

  Future<void> save() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(EditProfileSavingState());

    final result = await _editProfileRepo.updateProfile(
      request: RequestUpdateProfile(
        fullName: nameController.text.trim(),
        username: usernameController.text.trim(),
        address: addressController.text.trim(),
        photo: _photoChanged ? photoBytes : null,
      ),
    );
    if (isClosed) return;

    result.fold(
      (message) => emit(EditProfileErrorState(message: message)),
      (_) => emit(EditProfileSavedState()),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    usernameController.dispose();
    addressController.dispose();
    return super.close();
  }
}
