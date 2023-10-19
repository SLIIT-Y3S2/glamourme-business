import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart' as auth;
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
  Future<SalonModel> getSalon() async {
    late SalonModel salon;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    String userId = auth.FirebaseAuth.instance.currentUser!.uid;

    var userDoc = db.collection('users').doc(userId);
    late CollectionReference _salonCollection;

    _salonCollection = db.collection('salon-test');
    try {
      final salonSnapshot =
          await _salonCollection.where('salonOwner', isEqualTo: userDoc).get();

      // salonSnapshot.docs.forEach((salonDoc) {
      //   salon = SalonModel.fromJson(salonDoc);
      // });
      salon = SalonModel.fromJson(salonSnapshot.docs.first);
      return salon;
    } on StateError catch (error) {
      developer.log(error.runtimeType.toString(),
          name: 'Salon Repository error', stackTrace: error.stackTrace);
      throw Exception(error);
    } catch (error) {
      developer.log(error.toString(), name: 'Salon Repository error');
      throw Exception(error);
    }
  }
}
