import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ServiceModel {
  final String name;
  final String description;
  final String imageUrl;
  final num price;
  final String duration;
  final String id;

  // Constructor for creating a service from Firestore
  const ServiceModel({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
    required this.id,
  });

  // Constructor for creating a new service
  ServiceModel.init({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.duration,
  }) : id = uuid.v4();

  // Used to convert the object to a map for storing in Firestore
  toJson() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'duration': duration,
      'id': id,
    };
  }

  //Used to convert the map from Firestore to an object
  factory ServiceModel.fromJson(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return ServiceModel(
        name: doc.get('name'),
        description: doc.get('description'),
        imageUrl: doc.get('imageUrl'),
        price: doc.get('price'),
        duration: doc.get('duration'),
        id: doc.id);
  }
}
