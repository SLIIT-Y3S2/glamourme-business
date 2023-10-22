part of 'location_bloc.dart';

sealed class LocationEvent {
  const LocationEvent();
}

class GetLocationEvent extends LocationEvent {
  const GetLocationEvent();
}
