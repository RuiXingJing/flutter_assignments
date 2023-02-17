import 'package:flutter/material.dart';
import 'package:flutter_assignments/constants.dart';
import 'package:flutter_assignments/contacts/avatar/avatar_model.dart';
import 'package:image_picker/image_picker.dart';

class SelectAvatarPage extends StatefulWidget {
  SelectAvatarPage({super.key, required this.selectedAvatar});

  final String? selectedAvatar;

  final List<String> avatars = [
    'assets/images/avatar1.png',
    'assets/images/avatar2.png',
    'assets/images/avatar3.png',
    'assets/images/avatar4.png',
    'assets/images/avatar5.png',
    'assets/images/avatar6.png',
    'assets/images/avatar7.png',
    'assets/images/avatar8.png',
    'assets/images/avatar9.jpeg',
    'assets/images/avatar10.jpeg',
    'assets/images/avatar11.jpeg',
    'assets/images/avatar12.jpeg',
    'assets/images/avatar13.jpeg',
    'assets/images/avatar14.jpeg',
    'assets/images/avatar15.jpeg',
    'assets/images/avatar16.jpeg',
  ];

  @override
  State<StatefulWidget> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState extends State<SelectAvatarPage> {
  String? newSelectedAvatar;
  XFile? photo;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  bool isFromGallery = false;

  @override
  void initState() {
    super.initState();
    newSelectedAvatar = widget.selectedAvatar;
  }

  _onBackToPreviousPage() {
    var avatar = Avatar();
    if (photo != null) {
      avatar.photo = photo;
      avatar.pickPhotoError = _pickImageError;
    } else if (newSelectedAvatar != null) {
      avatar.defaultAvatar = newSelectedAvatar;
    } else {
      Navigator.of(context).pop();
      return;
    }
    Navigator.of(context).pop(avatar);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Avatar'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              _onBackToPreviousPage();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(Paddings.padding10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            itemCount: widget.avatars.length,
            itemBuilder: (context, index) {
              return _gridItem(context, index);
            },
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Semantics(
                label: 'image_picker_example_from_gallery',
                child: FloatingActionButton(
                  onPressed: () {
                    isFromGallery = true;
                    _onImageButtonPressed(ImageSource.gallery);
                  },
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  isFromGallery = false;
                  _onImageButtonPressed(ImageSource.camera);
                },
                heroTag: 'image1',
                tooltip: 'Take a Photo',
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    _onBackToPreviousPage();
    return true;
  }

  _gridItem(BuildContext context, int index) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              newSelectedAvatar = widget.avatars[index];
            });
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(
              widget.avatars[index],
            ),
            radius: 40,
          ),
        ),
        Positioned(
          left: 55,
          top: 55,
          child: _getSelectedIcon(index),
        )
      ],
    );
  }

  _getSelectedIcon(int index) {
    if (widget.avatars[index] == newSelectedAvatar) {
      return const Icon(
        Icons.check_rounded,
        color: Colors.green,
        size: 35,
      );
    }
    return Container();
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
          source: source, maxWidth: 400, maxHeight: 400, imageQuality: 40);
      if (pickedFile == null) {
        photo = await retrieveLostData();
      } else {
        photo = pickedFile;
      }
      newSelectedAvatar = photo?.path;
      if (photo != null) {
        _onBackToPreviousPage();
      }
    } catch (e) {
      _pickImageError = e;
    }
  }

  Future<XFile?> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return null;
    }
    if (response.file != null && response.type == RetrieveType.image) {
      return response.file;
    }
    return null;
  }
}

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
