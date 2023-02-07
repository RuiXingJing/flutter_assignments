import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/add_update_contact/view/add_update_contact_page.dart';

import '../../data/model/Contact.dart';

class ContactItemWidget extends StatelessWidget {
  ContactItemWidget({required this.contact}) : super(key: ObjectKey(contact));

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        _queryItemDetail(context);
      },
      leading: _avatarContainer(context),
      title: Text(
        contact.name,
      ),
      subtitle: Text(
        contact.mobile,
      ),
    );
  }

  _avatarContainer(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: _getAvatarChild(context),
        ),
        Positioned(
            left: 40,
            top: 40,
            child: contact.isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                    size: 18,
                  )
                : Container()),
      ],
    );
  }

  _getAvatarChild(BuildContext context) {
    if (contact.photo?.isNotEmpty == true) {
      return CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: AssetImage(contact.photo!));
    } else {
      return CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(contact.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600)));
    }
  }

  void _queryItemDetail(BuildContext context) {
      Navigator.push(context, AddContactPage.route(contact: contact));
  }
}
