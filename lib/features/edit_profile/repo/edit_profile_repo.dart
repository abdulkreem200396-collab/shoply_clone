import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/profile/request_update_profile.dart';
import 'package:shoply_clone/core/model/profile/response_profile.dart';
import 'package:shoply_clone/core/usecase/profile/profile_usecase.dart';

class EditProfileRepo {
  final _profileUsecase = ProfileUsecase();

  Future<Either<String, ResponseProfile>> getProfile() {
    return _profileUsecase.getProfile();
  }

  Future<Either<String, Unit>> updateProfile({
    required RequestUpdateProfile request,
  }) {
    return _profileUsecase.updateProfile(request: request);
  }
}
