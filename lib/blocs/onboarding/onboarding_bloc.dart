import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnBoardingInitialState()) {
    on<OnBoardingNextEvent>((event, emit) {
      int index = event.index;
      index++;
      emit(OnBoardingNextState(index: index));
    });
    on<OnBoardingPreviousEvent>((event, emit) {
      int index = event.index;
      index--;
      emit(OnBoardingPreviousState(index: index));
    });
  }
}
