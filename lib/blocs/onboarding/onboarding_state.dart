part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {
  late int index;
}

class OnBoardingInitialState extends OnboardingState {
  int index = 0;
  OnBoardingInitialState();
}

class OnBoardingNextState extends OnboardingState {
  int index;
  OnBoardingNextState({required this.index});
}

class OnBoardingPreviousState extends OnboardingState {
  int index;
  OnBoardingPreviousState({required this.index});
}
