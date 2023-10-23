part of 'location_bloc.dart';

sealed class LocationState {
  const LocationState();
}

final class LocationInitial extends LocationState {}

final class LocationLoaded extends LocationState {
  final LocationModel location;

  const LocationLoaded({required this.location});
}

final class GettingLocation extends LocationState {
  const GettingLocation();
}
