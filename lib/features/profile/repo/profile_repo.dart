import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/profile/response_profile.dart';
import 'package:shoply_clone/core/usecase/logout/logout_usecase.dart';
import 'package:shoply_clone/core/usecase/profile/profile_usecase.dart';

class ProfileRepo {
  final _profileUsecase = ProfileUsecase();
  final _logoutUsecase = LogoutUsecase();

  Future<Either<String, ResponseProfile>> getProfile() {
    return _profileUsecase.getProfile();
  }

  Future<void> logout() => _logoutUsecase.logout();
}
