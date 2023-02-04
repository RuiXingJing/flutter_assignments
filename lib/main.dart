import 'package:flutter/material.dart';
import 'package:flutter_assignments/data/db/db_provider.dart';
import 'package:flutter_assignments/home_page.dart';

import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  DatabaseProvider().initDB();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appName,
        theme:
            ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'OpenSans'),
        home: const HomePage());
  }
}
