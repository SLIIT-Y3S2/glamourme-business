part of 'salon_bloc.dart';

@immutable
sealed class SalonEvent {
  const SalonEvent();
}

class GetSalonEvent extends SalonEvent {
  const GetSalonEvent();
}

class CreateSalonEvent extends SalonEvent {
  final SalonModel salon;
  const CreateSalonEvent({required this.salon});
}

class ValidateSalonEvent extends SalonEvent {
  final SalonModel salon;
  const ValidateSalonEvent({required this.salon});
}

class UpdateSalonEvent extends SalonEvent {
  final SalonModel salon;
  const UpdateSalonEvent({required this.salon});
}

class DeleteSalonEvent extends SalonEvent {
  final String salonId;
  const DeleteSalonEvent({required this.salonId});
}

class CreateServiceEvent extends SalonEvent {
  final ServiceModel service;
  final String salonId;
  const CreateServiceEvent({required this.service, required this.salonId});
}
