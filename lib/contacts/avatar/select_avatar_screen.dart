import 'package:flutter/material.dart';
import 'package:flutter_assignments/constants.dart';

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
    'assets/images/avatar17.jpeg',
  ];

  @override
  State<StatefulWidget> createState() => _SelectAvatarPageState();
}

class _SelectAvatarPageState extends State<SelectAvatarPage> {
  String? newSelectedAvatar;

  @override
  void initState() {
    super.initState();
    newSelectedAvatar = widget.selectedAvatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select Avatar'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(newSelectedAvatar);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(Paddings.padding10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.0),
            itemCount: widget.avatars.length,
            itemBuilder: (context, index) {
              return _gridItem(context, index);
            },
          ),
        ));
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
}
