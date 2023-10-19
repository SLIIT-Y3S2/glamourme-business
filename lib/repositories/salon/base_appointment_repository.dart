import 'package:glamourmebusiness/models/salon_model.dart';

abstract class BaseSalonRepository {
  Stream<List<SalonModel>> getSalons();
  Future<void> createSalon(SalonModel salon);
}
