import 'package:geolocator/geolocator.dart';
import 'package:glamourmebusiness/models/location_model.dart';

abstract class BaseLocationRepository {
  Future<LocationModel> getLocation();
}
