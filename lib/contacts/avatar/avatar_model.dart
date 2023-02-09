import 'package:image_picker/image_picker.dart';

class Avatar {
  Avatar(
      {this.defaultAvatar,
      this.photo,
      this.pickPhotoError});

  String? defaultAvatar;
  XFile? photo;
  dynamic pickPhotoError;

  static bool isDefaultAvatar(String path) {
    return path.startsWith('assets/');
  }
}
