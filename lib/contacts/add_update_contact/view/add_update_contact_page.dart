import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/add_update_contact/bloc/add_update_contact_bloc.dart';
import 'package:flutter_assignments/contacts/add_update_contact/view/add_update_contact_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../../../data/model/Contact.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key, this.selectedContact});

  final Contact? selectedContact;

  static Route<void> route({Contact? contact}) {
    return MaterialPageRoute(
        builder: (_) => AddContactPage(selectedContact: contact));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedContact != null
            ? Strings.pageTitleUpdateContact
            : Strings.pageTitleAddContact),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Paddings.padding16),
        child: BlocProvider(
          create: (context) {
            return AddContactBloc(currentContact: selectedContact);
          },
          child: const AddContactForm(),
        ),
      ),
    );
  }
}
