part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class OnBoardingNextEvent extends OnboardingEvent {
  final int index;
  OnBoardingNextEvent({required this.index});
}

class OnBoardingPreviousEvent extends OnboardingEvent {
  final int index;
  OnBoardingPreviousEvent({required this.index});
}
