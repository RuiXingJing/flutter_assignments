import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/add_contact/bloc/add_contact_bloc.dart';
import 'package:flutter_assignments/contacts/add_contact/view/add_contact_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const AddContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleAddContact),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Paddings.padding16),
        child: BlocProvider(
          create: (context) {
            return AddContactBloc();
          },
          child: const AddContactForm(),
        ),
      ),
    );
  }
}
