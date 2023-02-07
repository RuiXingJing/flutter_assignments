import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/Contact.dart';
import 'base_table.dart';

class ContactTable extends BaseTable {
  static const String tableName = 'contacts';

  @override
  createTable() {
    return 'CREATE TABLE $tableName('
        'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        'name TEXT, '
        'mobile TEXT,'
        'landline TEXT,'
        'photo TEXT,'
        'isFavorite INTEGER)';
  }

  @override
  deleteData(num id) async {
    final db = await database;
    final int result = await db.delete(tableName, where: 'id=$id');
    debugPrint('[DB] Delete data from $tableName, result = $result');
  }

  @override
  insertData(Map<String, dynamic> dataMap) async {
    final db = await database;
    return await db.insert(tableName, dataMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  queryAll({bool? isFavorite}) async {
    final db = await database;
    String? condition = isFavorite == true ? 'isFavorite=1' : null;
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: condition, orderBy: 'name ASC');

    return List.generate(results.length, (index) {
      return Contact(
          results[index]['id'],
          results[index]['name'],
          results[index]['mobile'],
          results[index]['isFavorite'] == 1 ? true : false,
          landline: results[index]['landline'],
          photo: results[index]['photo']);
    });
  }

  @override
  queryData(num id) async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db.query(tableName, where: 'id:$id');

    if (results.isNotEmpty) {
      return Contact(results[0]['id'], results[0]['name'], results[0]['mobile'],
          results[0]['isFavorite'] == 1 ? true : false,
          landline: results[0]['landline'], photo: results[0]['photo']);
    }
    return null;
  }

  @override
  updateData(Map<String, dynamic> dataMap, num id) async {
    final db = await database;
    final int result = await db.update(tableName, dataMap, where: 'id = ?', whereArgs: [id]);
    debugPrint(
        '[DB] Update data in $tableName, result = $result, dataMap=$dataMap');
  }
}
