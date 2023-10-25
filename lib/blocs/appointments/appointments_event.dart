part of 'appointments_bloc.dart';

@immutable
sealed class AppointmentEvent {
  const AppointmentEvent();
}

class CreateAppointmentEvent extends AppointmentEvent {
  final AppointmentModel appointment;

  const CreateAppointmentEvent({required this.appointment});
}

class ValidateAppointmentEvent extends AppointmentEvent {
  final AppointmentModel appointment;

  const ValidateAppointmentEvent({required this.appointment});
}

class GetAppointmentsEvent extends AppointmentEvent {
  final String userId;

  const GetAppointmentsEvent({required this.userId});
}

class CancelAppointmentEvent extends AppointmentEvent {
  final String appointmentId;

  const CancelAppointmentEvent({required this.appointmentId});
}

class IsTimeSlotAvailableEvent extends AppointmentEvent {
  final AppointmentModel appointment;

  const IsTimeSlotAvailableEvent({required this.appointment});
}
