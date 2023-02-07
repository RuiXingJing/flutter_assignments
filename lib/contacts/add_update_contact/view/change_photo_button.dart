import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../avatar/select_avatar_screen.dart';
import '../bloc/add_update_contact_bloc.dart';

class PhotoButton extends StatefulWidget {
  const PhotoButton({super.key, this.avatar});

  final String? avatar;

  @override
  State<StatefulWidget> createState() => _PhotoButtonState();
}

class _PhotoButtonState extends State<PhotoButton> {
  String? selectedAvatar;

  @override
  void initState() {
    super.initState();
    selectedAvatar = widget.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddContactBloc, AddContactState>(
        builder: (context, state) {
      if (selectedAvatar != null) {
        context.read<AddContactBloc>().add(PhotoChangedEvent(selectedAvatar!));
      }
      return selectedAvatar != null
          ? GestureDetector(
              onTap: () {
                _onPhotoButtonClicked();
              },
              child: AvatarContainer(avatarPath: selectedAvatar!),
            )
          : Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(40)),
              child: IconButton(
                onPressed: () {
                  _onPhotoButtonClicked();
                },
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            );
    });
  }

  _onPhotoButtonClicked() async {
    Object? avatar = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return SelectAvatarPage(selectedAvatar: selectedAvatar);
    }));

    if (avatar != null) {
      setState(() {
        selectedAvatar = avatar.toString();
      });
    }
  }
}

class AvatarContainer extends StatelessWidget {
  const AvatarContainer({super.key, required this.avatarPath});

  final String avatarPath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage:  AssetImage(avatarPath),
            radius: 40,
          ),
          const Positioned(
              left: 65,
              top: 65,
              child: Icon(
                Icons.camera_alt_outlined,
                size: 15,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }
}
