import 'package:bloc/bloc.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/models/service_model.dart';
import 'package:glamourmebusiness/repositories/salon/salon_repository.dart';
import 'package:meta/meta.dart';
// import 'package:equatable/equatable.dart';

part 'salon_event.dart';
part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  final SalonRepository _salonRepository = SalonRepository();

  SalonBloc() : super(SalonInitial()) {
    on<CreateSalonEvent>(_onCreateSalonEvent);
    on<GetSalonEvent>(_onGetSalonEvent);
    on<ValidateSalonEvent>(_onValidateSalonEvent);
    on<CreateServiceEvent>(_onCreateServiceEvent);
  }

  void _onCreateSalonEvent(
    CreateSalonEvent event,
    Emitter<SalonState> emit,
  ) async {
    emit(CreatingSalonSate());
    await _salonRepository.createSalon(event.salon).then((salon) {
      emit(const SalonCreatedState());
    }).onError((error, stackTrace) {
      emit(SalonError(message: error.toString()));
    });
  }

  void _onGetSalonEvent(GetSalonEvent event, Emitter<SalonState> emit) async {
    emit(SalonLoading());
    await _salonRepository.getSalon().then((salon) {
      emit(SalonLoaded(salon: salon));
    }).onError((error, stackTrace) {
      emit(SalonError(message: error.toString()));
    });
  }

  void _onCreateServiceEvent(
    CreateServiceEvent event,
    Emitter<SalonState> emit,
  ) async {
    emit(CreatingSalonSate());
    await _salonRepository
        .createService(event.service, event.salonId)
        .then((_) {
      emit(ServiceCreatedState());
    }).onError((error, stackTrace) {
      emit(SalonError(message: error.toString()));
    });
  }

  void _onValidateSalonEvent(
      ValidateSalonEvent event, Emitter<SalonState> emit) {
    emit(ValidatingSalonState());
    _salonRepository.createSalon(event.salon).then((salon) {
      emit(SalonValidatedState(salon: salon));
    }).onError((error, stackTrace) {
      emit(SalonError(message: error.toString()));
    });
  }
}
