import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/models/service_model.dart';
import 'package:glamourmebusiness/repositories/salon/base_salon_repository.dart';

class SalonRepository extends BaseSalonRepository {
  @override
  Future<SalonModel> createSalon(SalonModel salon) async {
    // developer.log(salon.toJson().toString(), name: 'Salon input data');
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference salonCollection = db.collection('salons');
    developer.log(salon.toJson().toString(), name: 'working??');
    try {
      await salonCollection.doc(salon.salonId).set({
        ...salon.toJson(),
        'salonOwner': db.collection('users').doc(salon.salonOwnerId),
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value) {
        developer.log(salon.toJson().toString(), name: 'working??');
      }).onError((error, stackTrace) {
        developer.log(error.toString(), name: 'Salon error');
      });

      return salon;
    } catch (error) {
      developer.log(error.toString(), name: 'Salon creation error');
      throw Exception(error);
    }
  }

  @override
  Future<SalonModel> getSalon() async {
    late SalonModel salon;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    String userId = auth.FirebaseAuth.instance.currentUser!.uid;

    var userDoc = db.collection('users').doc(userId);

    try {
      final salonSnapshot = await db
          .collection('salons')
          .where('salonOwner', isEqualTo: userDoc)
          .get();

      if (salonSnapshot.docs.isNotEmpty) {
        final servicesSnapshot = salonSnapshot.docs.first;
        var services =
            await servicesSnapshot.reference.collection('services').get();
        salon = SalonModel.fromJson(servicesSnapshot, services);
      }

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

  @override
  Future<void> createService(ServiceModel service, String salonId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference serviceCollection =
        db.collection('salons').doc(salonId).collection('services');
    developer.log(salonId, name: "Working??");
    try {
      await serviceCollection.doc(service.id).set(service.toJson());
    } on TypeError catch (error) {
      developer.log(error.runtimeType.toString(),
          name: 'Service creation type error', stackTrace: error.stackTrace);
      throw Exception(error);
    } on StateError catch (error) {
      developer.log(error.runtimeType.toString(),
          name: 'Service creation error', stackTrace: error.stackTrace);
      throw Exception(error);
    } catch (error) {
      developer.log(error.toString(), name: 'Service creation error');
      throw Exception(error);
    }
  }
}
