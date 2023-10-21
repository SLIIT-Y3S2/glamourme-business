import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/service_model.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Affordability {
  affordable,
  pricey,
}

enum GenderType {
  gents,
  ladies,
  unisex,
}

class SalonModel {
  final String? salonId;
  final String salonName;
  final GenderType salonType;
  final String? website;
  final String location;
  final String imageUrl;
  final String description;
  final String contactNumber;
  final double rating;
  final Affordability affordability;
  final double latitude;
  final double longitude;
  final String salonOwnerId;
  final List<ServiceModel> services;
  final List<CategoryModel> categories;
  final List<OpeningHoursDataModel> openingHours;

  SalonModel({
    required this.salonId,
    required this.salonName,
    this.website,
    required this.salonType,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.contactNumber,
    required this.rating,
    required this.affordability,
    required this.latitude,
    required this.longitude,
    required this.salonOwnerId,
    required this.categories,
    required this.services,
    required this.openingHours,
  });

  SalonModel.init({
    required this.salonName,
    required website,
    required salonType,
    required this.categories,
    required this.location,
    required this.openingHours,
    required this.contactNumber,
    required this.salonOwnerId,
    imageUrl,
    description,
    rating,
    affordability,
    longitude,
    latitude,
    services,
  })  : salonId = uuid.v4(),
        website = website ?? '',
        services = services ?? [],
        salonType = salonType == 'gents'
            ? GenderType.gents
            : salonType == 'ladies'
                ? GenderType.ladies
                : GenderType.unisex,
        imageUrl = imageUrl ?? '',
        description = description ?? '',
        rating = rating ?? 0,
        affordability = affordability ?? Affordability.affordable,
        latitude = latitude ?? 0,
        longitude = longitude ?? 0;

  Map<String, dynamic> toJson() {
    return {
      'salonId': salonId,
      'salonName': salonName,
      'website': website,
      'salonType': salonType == GenderType.gents
          ? 'gents'
          : salonType == GenderType.ladies
              ? 'ladies'
              : 'unisex',
      'location': location,
      'contactNumber': contactNumber,
      'salonOwner': salonOwnerId,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'affordability': affordability == Affordability.affordable
          ? 'affordable'
          : affordability == Affordability.pricey
              ? 'pricey'
              : 'luxurious',
      'longitude': longitude,
      'latitude': latitude,
      'openingHours': openingHours.map((openingHour) => openingHour.toJson()),
      'categories': categories.map((category) => category.toJson()).toList(),
      'services': services.map((service) => service.toJson()).toList(),
    };
  }

  factory SalonModel.fromJson(
    QueryDocumentSnapshot doc,
    QuerySnapshot<Map<String, dynamic>> services,
  ) {
    final List<CategoryModel> salonCategories = [];
    final List<OpeningHoursDataModel> openingHours = [];
    final List<ServiceModel> salonServices = [];

    for (var service in services.docs) {
      ServiceModel serviceModel = ServiceModel.fromJson(service);
      salonServices.add(serviceModel);
    }

    for (var category in doc.get('categories')) {
      CategoryModel categoryModel = CategoryModel.fromJson(category);
      salonCategories.add(categoryModel);
    }

    for (var openingHour in doc.get('openingHours')) {
      OpeningHoursDataModel openingHourModel =
          OpeningHoursDataModel.fromJson(openingHour);
      openingHours.add(openingHourModel);
    }

    // for one salon
    return SalonModel(
      salonId: doc.id,
      salonName: doc.get('salonName'),
      location: doc.get('location'),
      imageUrl: doc.get('imageUrl'),
      description: doc.get('description'),
      contactNumber: doc.get('contactNumber'),
      rating: doc.get('rating'),
      affordability: doc.get('affordability') == 'affordable'
          ? Affordability.affordable
          : Affordability.pricey,
      latitude: doc.get('latitude'),
      longitude: doc.get('longitude'),
      salonType: doc.get('salonType') == 'gents'
          ? GenderType.gents
          : doc.get('salonType') == 'ladies'
              ? GenderType.ladies
              : GenderType.unisex,
      salonOwnerId: doc.get("salonOwner").path.toString().split('/')[1],
      services: salonServices,
      categories: salonCategories,
      openingHours: openingHours,
    );
  }
}

class OpeningHoursDataModel {
  final String day;
  TimeOfDay openingTime;
  TimeOfDay closingTime;
  bool isOpen;

  OpeningHoursDataModel({
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen,
  });

  Map<String, dynamic> toJson() {
    final now = DateTime.now();
    var openingTimeTimeStamp = DateTime(
        now.year, now.month, now.day, openingTime.hour, openingTime.minute);
    var closingTimeStamp = DateTime(
        now.year, now.month, now.day, closingTime.hour, closingTime.minute);
    return {
      'day': day,
      'openingTime': openingTimeTimeStamp,
      'closingTime': closingTimeStamp,
      'isOpen': isOpen,
    };
  }

  factory OpeningHoursDataModel.fromJson(Map<String, dynamic> json) {
    return OpeningHoursDataModel(
      day: json['day'],
      openingTime: TimeOfDay.fromDateTime(json['openingTime'].toDate()),
      closingTime: TimeOfDay.fromDateTime(json['closingTime'].toDate()),
      isOpen: json['isOpen'],
    );
  }
}

class BasicSalonDetails {
  final String salonName;
  final String salonType;
  final String website;
  const BasicSalonDetails({
    required this.salonName,
    required this.salonType,
    required this.website,
  });
}
