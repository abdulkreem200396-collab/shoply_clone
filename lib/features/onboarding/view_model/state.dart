abstract class OnboardingState {}

class OnboardingInitState extends OnboardingState {}

class OnboardingPageChangedState extends OnboardingState {
  OnboardingPageChangedState({required this.index});

  final int index;
}

class OnboardingFinishedState extends OnboardingState {}
