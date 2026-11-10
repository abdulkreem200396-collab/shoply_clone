import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/routes/app_pages.dart';
import 'package:shoply_clone/core/usecase/auth_status/auth_status_usecase.dart';
import 'package:shoply_clone/features/splash/repo/splash_repo.dart';
import 'package:shoply_clone/features/splash/view_model/state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitState());

  final _splashRepo = SplashRepo();

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;

    final route = switch (_splashRepo.getAuthStatus()) {
      AuthStatus.verified => AppPages.mainScreen,
      AuthStatus.unverified => AppPages.verifyEmailScreen,
      AuthStatus.loggedOut =>
        _splashRepo.seenOnboarding
            ? AppPages.loginScreen
            : AppPages.onBoardingScreen,
    };

    emit(SplashNavigateState(route: route));
  }
}
