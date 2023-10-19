import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/repositories/salon/base_appointment_repository.dart';

class SalonRepository extends BaseSalonRepository {
  @override
  Future<SalonModel> createSalon(SalonModel salon) async {
    // developer.log(salon.toJson().toString(), name: 'Salon input data');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference salonCollection = db.collection('salon-test');
    developer.log(salon.toJson().toString(), name: 'working??');

    await salonCollection.doc(salon.salonId).set({
      ...salon.toJson(),
      'salonOwner': db.collection('users').doc(salon.salonOwnerId),
    }).then((value) {
      developer.log(salon.toJson().toString(), name: 'working??');
    }).onError((error, stackTrace) {
      developer.log(error.toString(), name: 'Salon error');
    });

    return salon;
  }

  @override
  Stream<List<SalonModel>> getSalons() {
    // TODO: implement getSalons
    throw UnimplementedError();
  }
}
