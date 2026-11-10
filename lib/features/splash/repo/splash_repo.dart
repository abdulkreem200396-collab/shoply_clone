import 'package:shoply_clone/core/local/local_storage.dart';
import 'package:shoply_clone/core/usecase/auth_status/auth_status_usecase.dart';

class SplashRepo {
  final _authStatusUsecase = AuthStatusUsecase();

  AuthStatus getAuthStatus() => _authStatusUsecase.getStatus();

  bool get seenOnboarding => LocalStorage.instance.seenOnboarding;
}
