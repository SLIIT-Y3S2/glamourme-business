import 'package:glamourmebusiness/models/salon_model.dart';

abstract class BaseSalonRepository {
  Future<SalonModel> getSalon();
  Future<void> createSalon(SalonModel salon);
}
