import 'package:flutter/material.dart';

import '../../constants.dart';
import 'package:flutter_assignments/contacts/add_contact/view/add_contact_page.dart';
import 'package:flutter_assignments/contacts/contact_list/contact_item_widget.dart';
import 'package:flutter_assignments/contacts/contact_list/contacts_helper.dart';
import 'package:flutter_assignments/data/model/contact.dart';

class FavoriteContactsPage extends StatelessWidget {
  const FavoriteContactsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const FavoriteContactsPage());
  }

  @override
  Widget build(BuildContext context) {
    contactHelper.getFavoriteContacts();
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleFavoriteContact),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AddContactPage.route());
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Contact>>(
        stream: contactHelper.favoriteContacts,
        builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ContactItemWidget(contact: snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('Add your first contact'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
