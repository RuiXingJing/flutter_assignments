import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_assignments/contacts/add_update_contact/model/models.dart';
import 'package:formz/formz.dart';

import '../../../data/model/Contact.dart';
import '../../contact_list/contacts_helper.dart';

part 'add_update_contact_event.dart';

part 'add_update_contact_state.dart';

class AddContactBloc extends Bloc<AddContactEvent, AddContactState> {
  AddContactBloc({this.currentContact})
      : super(
          AddContactState(
              name: currentContact?.name.isNotEmpty == true
                  ? NameInput.dirty(currentContact!.name)
                  : const NameInput.pure(),
              mobile: currentContact?.mobile.isNotEmpty == true
                  ? MobileInput.dirty(currentContact!.mobile)
                  : const MobileInput.pure(),
              landline: currentContact?.landline ?? '',
              isFavorite: currentContact?.isFavorite == true,
              photo: currentContact?.photo ?? '',
              id: currentContact?.id ?? -1),
        ) {
    on<NameChangedEvent>(_onNameChanged);
    on<MobileChangedEvent>(_onMobileChanged);
    on<IsFavoriteChangedEvent>(_onIsFavoriteChanged);
    on<PhotoChangedEvent>(_onPhotoChanged);
    on<LandlineChangedEvent>(_onLandlineChanged);
    on<AddOrUpdateSubmittedEvent>(_onAddOrUpdateSubmitted);
    on<DeleteSubmittedEvent>(_onDeleteSubmitted);
  }

  final Contact? currentContact;

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
    emit(state.copyWith(
        isFavorite: event.isFavorite,
        status: Formz.validate([state.name, state.mobile])));
  }

  void _onPhotoChanged(PhotoChangedEvent event, Emitter<AddContactState> emit) {
    emit(state.copyWith(
        photo: event.photo,
        status: Formz.validate([state.name, state.mobile])));
  }

  void _onLandlineChanged(
      LandlineChangedEvent event, Emitter<AddContactState> emit) {
    emit(state.copyWith(
        landline: event.landline,
        status: Formz.validate([state.name, state.mobile])));
  }

  void _onAddOrUpdateSubmitted(
      AddOrUpdateSubmittedEvent event, Emitter<AddContactState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        if (state.id > 0) {
          await contactHelper.updateContact(state.convertToMap(), state.id);
        } else {
          await contactHelper.addContact(state.convertToMap());
        }
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } else {
      final name = NameInput.dirty(state.name.value);
      final mobile = MobileInput.dirty(state.mobile.value);
      var status = Formz.validate([name, mobile]);
      emit(state.copyWith(status: status, name: name, mobile: mobile));
    }
  }

  void _onDeleteSubmitted(
      DeleteSubmittedEvent event, Emitter<AddContactState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await contactHelper.deleteContact(state.id);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
