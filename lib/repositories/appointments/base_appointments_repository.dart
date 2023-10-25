import 'package:glamourmebusiness/models/appointment_model.dart';

abstract class BaseAppointmentRepository {
  Future<List<AppointmentModel>> getAppointments(String userId);
  Future<AppointmentModel> getAppointment(int id);
  Future<AppointmentModel> createAppointment(AppointmentModel appointment);
  Future<AppointmentModel> updateAppointment(AppointmentModel appointment);
  Future<void> cancelAppointment(String id);
  Future<bool> validateAppointment(AppointmentModel appointment);
  Future<bool> isTImeSlotAvailable(AppointmentModel appointment);
}
