import 'dart:convert';

import 'package:glamourmebusiness/models/location_model.dart';
import 'package:glamourmebusiness/repositories/location/base_location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationRepository extends BaseLocationRepository {
  @override
  Future<LocationModel> getLocation() async {
    late LocationModel location;
    final Position position = await Geolocator.getCurrentPosition();

    Uri reverseGeoCodingUri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyA-4V10fUXkkawZaJ6wC7CEidEEdY8ar3A');

    final response = await http.get(reverseGeoCodingUri);

    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    location = LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );

    return location;
  }
}
