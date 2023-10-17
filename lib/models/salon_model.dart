import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glamourmebusiness/models/service_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Affordability {
  affordable,
  pricey,
}

enum SalonType {
  gents,
  ladies,
  unisex,
}

class SalonModel {
  final String? salonId;
  final String salonName;
  final String location;
  final String imageUrl;
  final String description;
  final String contactNumber;
  final double rating;
  final Affordability affordability;
  final List<ServiceModel>? services;
  final double latitude;
  final double longitude;
  final SalonType salonType;

  const SalonModel({
    required this.salonId,
    required this.salonName,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.contactNumber,
    required this.rating,
    required this.affordability,
    required this.services,
    required this.latitude,
    required this.longitude,
    required this.salonType,
  });

  SalonModel.init({
    required this.salonName,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.contactNumber,
    required this.rating,
    required this.affordability,
    required services,
    required this.latitude,
    required this.longitude,
    required this.salonType,
  })  : salonId = uuid.v4(),
        services = services ?? [];

  toJson() {
    return {
      'salonId': salonId,
      'salonName': salonName,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
      'contactNumber': contactNumber,
      'rating': rating,
      'affordability': affordability == Affordability.affordable
          ? 'affordable'
          : affordability == Affordability.pricey
              ? 'pricey'
              : 'luxurious',
      'services': services?.map((service) => service.toJson()).toList() ?? [],
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory SalonModel.fromJson(QueryDocumentSnapshot doc) {
    final List<ServiceModel> salonServices = [];
    doc.reference.collection('services').get().then((services) {
      for (var service in services.docs) {
        ServiceModel serviceModel = ServiceModel.fromJson(service);
        salonServices.add(serviceModel);
      }
    });
    return SalonModel(
      salonId: doc.id,
      salonName: doc.get('salon'),
      location: doc.get('location'),
      imageUrl: doc.get('imageUrl'),
      description: doc.get('description'),
      contactNumber: doc.get('contactNumber'),
      rating: doc.get('rating'),
      affordability: doc.get('affordability') == 'affordable'
          ? Affordability.affordable
          : Affordability.pricey,
      services: salonServices,
      latitude: doc.get('latitude'),
      longitude: doc.get('longitude'),
      salonType: doc.get('salonType') == 'gents'
          ? SalonType.gents
          : doc.get('salonType') == 'ladies'
              ? SalonType.ladies
              : SalonType.unisex,
    );
  }
}
