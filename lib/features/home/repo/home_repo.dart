import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/usecase/profile/profile_usecase.dart';

class HomeRepo {
  final _profileUsecase = ProfileUsecase();

  Future<Either<String, String>> getUserName() async {
    final result = await _profileUsecase.getProfile();
    return result.map((profile) => profile.fullName);
  }
}
