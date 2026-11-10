import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_clone/core/local/local_storage.dart';
import 'package:shoply_clone/features/onboarding/view_model/state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitState());

  static const int pagesCount = 3;

  final pageController = PageController();
  int currentIndex = 0;

  bool get isLastPage => currentIndex == pagesCount - 1;

  void onPageChanged(int index) {
    currentIndex = index;
    emit(OnboardingPageChangedState(index: index));
  }

  void next() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void skip() {
    pageController.animateToPage(
      pagesCount - 1,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  Future<void> finish() async {
    await LocalStorage.instance.setSeenOnboarding(true);
    if (isClosed) return;
    emit(OnboardingFinishedState());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
