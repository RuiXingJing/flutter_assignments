part of 'add_update_contact_bloc.dart';

abstract class AddContactEvent extends Equatable {
  const AddContactEvent();

  @override
  List<Object> get props => [];
}

class NameChangedEvent extends AddContactEvent {
  const NameChangedEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class MobileChangedEvent extends AddContactEvent {
  const MobileChangedEvent(this.mobile);

  final String mobile;

  @override
  List<Object> get props => [mobile];
}

class PhotoChangedEvent extends AddContactEvent {
  const PhotoChangedEvent(this.photo);

  final String photo;

  @override
  List<Object> get props => [photo];
}

class LandlineChangedEvent extends AddContactEvent {
  const LandlineChangedEvent(this.landline);

  final String landline;

  @override
  List<Object> get props => [landline];
}

class IsFavoriteChangedEvent extends AddContactEvent {
  const IsFavoriteChangedEvent(this.isFavorite);

  final bool isFavorite;

  @override
  List<Object> get props => [isFavorite];
}

class AddOrUpdateSubmittedEvent extends AddContactEvent {
  const AddOrUpdateSubmittedEvent();
}

class DeleteSubmittedEvent extends AddContactEvent {
  const DeleteSubmittedEvent();
}
