import 'package:flutter/material.dart';

import '../constants.dart';

class TodoMainPage extends StatelessWidget {
  const TodoMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.pageTitleTodo),
        centerTitle: true,
      ),
    );
  }
}
