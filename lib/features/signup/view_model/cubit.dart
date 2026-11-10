import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/model/signup/request_signup.dart';
import 'package:shoply_clone/features/signup/repo/signup_repo.dart';
import 'package:shoply_clone/features/signup/view_model/state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitState());

  final _signupRepo = SignupRepo();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Uint8List? photoBytes;

  void setPhoto(Uint8List bytes) {
    photoBytes = bytes;
    emit(SignupPhotoChangedState());
  }

  Future<void> signup() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    emit(SignupLoadingState());

    final result = await _signupRepo.signup(
      requestSignup: RequestSignup(
        fullName: nameController.text.trim(),
        username: usernameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        password: passwordController.text,
        photo: photoBytes,
      ),
    );

    if (isClosed) return;

    result.fold(
      (errorMessage) => emit(SignupErrorState(errorMessage: errorMessage)),
      (responseSignup) => emit(SignupSuccessState()),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    return super.close();
  }
}
