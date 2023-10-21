import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/models/service_model.dart';

abstract class BaseSalonRepository {
  Future<SalonModel> getSalon();
  Future<void> createSalon(SalonModel salon);
  Future<void> createService(ServiceModel service, String salonId);
}
