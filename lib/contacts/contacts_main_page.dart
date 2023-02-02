import 'package:flutter/material.dart';

import '../constants.dart';

class ContactsMainPage extends StatelessWidget{
  const ContactsMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleContactList),
        centerTitle: true,
      ),
    );
  }
}