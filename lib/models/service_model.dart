import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

GenderType serviceGenderFromString(String serviceGender) =>
    serviceGender == 'gents'
        ? GenderType.gents
        : serviceGender == 'ladies'
            ? GenderType.ladies
            : GenderType.unisex;

class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final num price;
  final String duration;
  final GenderType serviceGender;

  // Constructor for creating a service from Firestore
  const ServiceModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
    required this.id,
    required this.serviceGender,
  });

  // Constructor for creating a new service
  ServiceModel.init({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
    required String serviceGender,
  })  : id = uuid.v4(),
        serviceGender = serviceGenderFromString(serviceGender);

  // Used to convert the object to a map for storing in Firestore
  toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'duration': duration,
      'serviceGender': serviceGender.toString().split('.').last,
    };
  }

  //Used to convert the map from Firestore to an object
  factory ServiceModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ServiceModel(
      id: doc.id,
      name: doc.get('name'),
      description: doc.get('description'),
      imageUrl: doc.get('imageUrl'),
      price: doc.get('price'),
      duration: doc.get('duration'),
      serviceGender: serviceGenderFromString(doc.get('serviceGender')),
    );
  }
}
