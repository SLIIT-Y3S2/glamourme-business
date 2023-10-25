import 'package:bloc/bloc.dart';
import 'package:glamourmebusiness/models/appointment_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/repositories/appointments/appointments_repository.dart';
import 'package:glamourmebusiness/repositories/salon/salon_repository.dart';
import 'package:meta/meta.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final SalonRepository _salonRepository = SalonRepository();

  AppointmentBloc() : super(AppointmentInitial()) {
    on<CreateAppointmentEvent>(_onCreateAppointment);
    on<ValidateAppointmentEvent>(_onValidateAppointment);
    on<GetAppointmentsEvent>(_onGetAppointmentsEvent);
    on<CancelAppointmentEvent>(_onCancelAppointmentEvent);
    on<IsTimeSlotAvailableEvent>(_onIsTimeSlotAvailableEvent);
  }

  void _onIsTimeSlotAvailableEvent(
    IsTimeSlotAvailableEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(LoadingAppoinments());
    await _appointmentRepository.isTImeSlotAvailable(event.appointment).then(
      (isAvailable) {
        emit(TimeSlotAvailableState(isAvailable: isAvailable));
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }

  void _onCancelAppointmentEvent(
    CancelAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(CancelingAppointmentState());
    await _appointmentRepository.cancelAppointment(event.appointmentId).then(
      (appointment) {
        emit(const AppointmentCanceledState());
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }

  void _onGetAppointmentsEvent(
    GetAppointmentsEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(LoadingAppoinments());
    final SalonModel salon = await _salonRepository.getSalon();
    await _appointmentRepository.getAppointments(salon.salonId!).then(
      (appointments) {
        emit(AppointmentsLoaded(appointments: appointments));
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }

  void _onCreateAppointment(
    CreateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) async {
    emit(CreatingAppointmentState());
    await _appointmentRepository.createAppointment(event.appointment).then(
      (appointment) {
        emit(const AppointmentCreatedState());
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }

  void _onValidateAppointment(
    ValidateAppointmentEvent event,
    Emitter<AppointmentState> emit,
  ) {
    emit(ValidatingAppointmentState());
    _appointmentRepository.createAppointment(event.appointment).then(
      (appointment) {
        emit(AppointmentValidatedState(appointment: appointment));
      },
    ).catchError(
      (error) {
        emit(AppointmentError(message: error.toString()));
      },
    );
  }
}
