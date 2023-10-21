part of 'salon_bloc.dart';

@immutable
sealed class SalonState {
  const SalonState();

  @override
  List<Object> get props => [];
}

class SalonInitial extends SalonState {}

class SalonLoading extends SalonState {}

class SalonLoaded extends SalonState {
  final SalonModel salon;
  const SalonLoaded({required this.salon});
}

class SalonError extends SalonState {
  final String message;
  const SalonError({required this.message});
}

class CreatingSalonSate extends SalonState {}

class SalonCreatedState extends SalonState {
  const SalonCreatedState();
}

class ValidatingSalonState extends SalonState {}

class CreatingServiceState extends SalonState {}

class ServiceCreatedState extends SalonState {}

class SalonValidatedState extends SalonState {
  final SalonModel salon;
  const SalonValidatedState({required this.salon});
}
