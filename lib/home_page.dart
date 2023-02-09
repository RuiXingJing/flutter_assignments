import 'package:flutter/material.dart';
import 'package:flutter_assignments/contacts/camera/camera_main_page.dart';
import 'package:flutter_assignments/todo/todo_main_page.dart';

import 'constants.dart';
import 'contacts/contacts_main_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
        ),
        body: Padding(
            padding: const EdgeInsets.all(Paddings.padding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(right: Paddings.padding20),
                        child: _assignmentButton(context,
                            Strings.buttonTextTodo, const TodoMainPage())),
                    Padding(
                        padding:
                            const EdgeInsets.only(right: Paddings.padding20),
                        child: _assignmentButton(
                            context,
                            Strings.buttonTextContact,
                            const ContactsMainPage())),
                  ],
                ),
                _assignmentButton(
                    context, 'Photo&Video Example', const CameraMainPage(title: 'Photo&Video Example',))
              ],
            )));
  }

  _assignmentButton(BuildContext context, String label, page) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => page));
        },
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ));
  }
}
