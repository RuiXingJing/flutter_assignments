import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assignments/contacts/add_contact/model/models.dart';
import 'package:formz/formz.dart';

import '../../contact_list/contacts_helper.dart';

part 'add_contact_event.dart';

part 'add_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc() : super(const AddContactState()) {
    on<NameChangedEvent>(_onNameChanged);
    on<MobileChangedEvent>(_onMobileChanged);
    on<IsFavoriteChangedEvent>(_onIsFavoriteChanged);
    on<PhotoChangedEvent>(_onPhotoChanged);
    on<LandlineChangedEvent>(_onLandlineChanged);
    on<AddSubmittedEvent>(_onAddSubmitted);
  }

  void _onNameChanged(NameChangedEvent event, Emitter<AddContactState> emit) {
    final name = NameInput.dirty(event.name);
    emit(state.copyWith(
        name: name, status: Formz.validate([state.mobile, name])));
  }

  void _onMobileChanged(
      MobileChangedEvent event, Emitter<AddContactState> emit) {
    final mobile = MobileInput.dirty(event.mobile);
    emit(state.copyWith(
        mobile: mobile, status: Formz.validate([state.name, mobile])));
  }

  void _onIsFavoriteChanged(
      IsFavoriteChangedEvent event, Emitter<AddContactState> emit) {
    emit(state.copyWith(isFavorite: event.isFavorite));
  }

  void _onPhotoChanged(PhotoChangedEvent event, Emitter<AddContactState> emit) {
    emit(state.copyWith(photo: event.photo));
  }

  void _onLandlineChanged(
      LandlineChangedEvent event, Emitter<AddContactState> emit) {
    emit(state.copyWith(landline: event.landline));
  }

  void _onAddSubmitted(
      AddSubmittedEvent event, Emitter<AddContactState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await contactHelper.addContact(state.convertToMap());
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}
