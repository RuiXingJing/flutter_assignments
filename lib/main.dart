import 'package:flutter/material.dart';
import 'package:flutter_assignments/home_page.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'OpenSans'
      ),
      home: const HomePage()
    );
  }
}
