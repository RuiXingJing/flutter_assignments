import 'package:sqflite/sqflite.dart';

abstract class BaseTable{
  late Future<Database> database;

  createTable();

  insertData(Map<String, dynamic> dataMap);

  queryAll({bool? isFavorite});

  queryData(num id);

  updateData(Map<String, dynamic> dataMap, num id);

  deleteData(num id);
}