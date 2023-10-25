part of 'appointments_bloc.dart';

@immutable
sealed class AppointmentState {
  const AppointmentState();
}

class AppointmentInitial extends AppointmentState {}

class LoadingAppoinments extends AppointmentState {}

class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;

  const AppointmentsLoaded({required this.appointments});
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError({required this.message});
}

class CreatingAppointmentState extends AppointmentState {}

final class AppointmentCreatedState extends AppointmentState {
  const AppointmentCreatedState();
}

class ValidatingAppointmentState extends AppointmentState {}

class AppointmentValidatedState extends AppointmentState {
  final AppointmentModel appointment;

  const AppointmentValidatedState({required this.appointment});
}

class CancelingAppointmentState extends AppointmentState {}

class AppointmentCanceledState extends AppointmentState {
  const AppointmentCanceledState();
}

class TimeSlotAvailableState extends AppointmentState {
  final bool isAvailable;

  const TimeSlotAvailableState({required this.isAvailable});
}
