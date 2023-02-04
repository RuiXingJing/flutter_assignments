import 'package:flutter_assignments/data/db/table/contact_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider _databaseProvider = DatabaseProvider._internal();

  Future<Database>? database;

  factory DatabaseProvider() {
    return _databaseProvider;
  }

  DatabaseProvider._internal();

  final ContactTable contactTable = ContactTable();

  initDB() async {
    try {
      if (database == null) {
        database = createDatabase();
        contactTable.database = database!;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Database> createDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(), "my_assignment.db"),
        version: 1, onCreate: (db, version) async {
      await db.execute(contactTable.createTable());
    }, onUpgrade: (db, oldVersion, newVersion) {
      if (newVersion > oldVersion) {}
    });
  }
}
