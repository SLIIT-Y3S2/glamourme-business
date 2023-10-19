import 'package:bloc/bloc.dart';
import 'package:glamourmebusiness/models/category_model.dart';
import 'package:glamourmebusiness/models/salon_model.dart';
import 'package:glamourmebusiness/repositories/salon/salon_repository.dart';
import 'package:meta/meta.dart';

part 'salon_event.dart';
part 'salon_state.dart';

class SalonBloc extends Bloc<SalonEvent, SalonState> {
  final SalonRepository _salonRepository = SalonRepository();

  SalonBloc() : super(SalonInitial()) {
    on<CreateSalonEvent>(_onCreateSalonEvent);
    on<ValidateSalonEvent>(_onValidateSalonEvent);
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
