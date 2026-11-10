import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/features/verify_email/repo/verify_email_repo.dart';
import 'package:shoply_clone/features/verify_email/view_model/state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitState());

  final _verifyEmailRepo = VerifyEmailRepo();

  String get email => _verifyEmailRepo.email;

  Future<void> checkVerified() async {
    emit(VerifyEmailLoadingState());

    final result = await _verifyEmailRepo.checkVerified();
    if (isClosed) return;

    result.fold((message) => emit(VerifyEmailErrorState(message: message)), (
      verified,
    ) {
      if (verified) {
        emit(VerifyEmailVerifiedState());
      } else {
        emit(VerifyEmailNotVerifiedState());
      }
    });
  }

  Future<void> resend() async {
    final result = await _verifyEmailRepo.resend();
    if (isClosed) return;

    result.fold(
      (message) => emit(VerifyEmailErrorState(message: message)),
      (_) => emit(VerifyEmailResentState()),
    );
  }

  Future<void> backToLogin() async {
    await _verifyEmailRepo.signOut();
    if (isClosed) return;
    emit(VerifyEmailSignedOutState());
  }
}
