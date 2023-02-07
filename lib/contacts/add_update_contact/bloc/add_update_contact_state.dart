part of 'add_update_contact_bloc.dart';

class AddContactState extends Equatable {
  const AddContactState(
      {this.status = FormzStatus.pure,
      this.name = const NameInput.pure(),
      this.mobile = const MobileInput.pure(),
      this.isFavorite = false,
      this.landline = '',
      this.photo = '',
      this.id = -1});

  final int id;
  final FormzStatus status;
  final NameInput name;
  final MobileInput mobile;
  final bool isFavorite;
  final String landline;
  final String photo;

  AddContactState copyWith(
      {FormzStatus? status,
      NameInput? name,
      MobileInput? mobile,
      bool? isFavorite,
      String? landline,
      String? photo}) {
    return AddContactState(
        status: status ?? this.status,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        isFavorite: isFavorite ?? this.isFavorite,
        landline: landline ?? this.landline,
        photo: photo ?? this.photo,
        id: id);
  }

  convertToMap() {
    return {
      'name': name.value,
      'mobile': mobile.value,
      'landline': landline,
      'photo': photo,
      'isFavorite': isFavorite ? 1 : 0
    };
  }

  @override
  List<Object> get props => [status, name, mobile, isFavorite, landline, photo];
}
