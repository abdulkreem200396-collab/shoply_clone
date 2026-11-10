import 'package:dartz/dartz.dart';
import 'package:shoply_clone/core/model/update_password/request_update_password.dart';
import 'package:shoply_clone/core/usecase/update_password/update_password_usecase.dart';

class UpdatePasswordRepo {
  final _updatePasswordUsecase = UpdatePasswordUsecase();

  Future<Either<String, Unit>> updatePassword({
    required RequestUpdatePassword request,
  }) async {
    return await _updatePasswordUsecase.updatePassword(request: request);
  }
}
