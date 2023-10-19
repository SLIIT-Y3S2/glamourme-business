part of 'salon_bloc.dart';

@immutable
sealed class SalonEvent {
  const SalonEvent();
}

class BasicSalonDetailsEntered extends SalonEvent {
  final String salonName;
  final String salonType;
  final String website;
  final String salonOwnerId;
  const BasicSalonDetailsEntered({
    required this.salonName,
    required this.salonType,
    required this.website,
    required this.salonOwnerId,
  });
}

class SalonCategoriesSelected extends SalonEvent {
  final List<CategoryModel> categories;
  const SalonCategoriesSelected({required this.categories});
}

class SalonLocationEntered extends SalonEvent {
  final String location;
  final double latitude;
  final double longitude;
  const SalonLocationEntered({
    required this.location,
    required this.latitude,
    required this.longitude,
  });
}

class SalonOpeningHoursEntered extends SalonEvent {
  final List<OpeningHoursDataModel> openingHours;
  const SalonOpeningHoursEntered({required this.openingHours});
}

class CreateSalonEvent extends SalonEvent {
  final SalonModel salon;
  const CreateSalonEvent({required this.salon});

  // new events
}

class ValidateSalonEvent extends SalonEvent {
  final SalonModel salon;
  const ValidateSalonEvent({required this.salon});
}
