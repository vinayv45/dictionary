import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    var dbDir = await getDatabasesPath();
    var dbPath = path.join(dbDir, "wordbook.db");
    ByteData data = await rootBundle.load("assets/database/wordbook.db");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);

    var db = await sql.openDatabase(dbPath);
    return db;
  }

  static Future getAllData() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM wordbook");
  }

  static Future seachByword(var wordName) async {
    final db = await DBHelper.database();
    return db.rawQuery(
        "SELECT * FROM wordbook WHERE langFullWord LIKE  '$wordName%' ");
  }

  // static Future seachByword(var wordName) async {
  //   final db = await DBHelper.database();
  //   return db.rawQuery(
  //       "SELECT * FROM wordbook WHERE langFullWord  MATCH  '$wordName' ");
  // }

  static Future searchResults(var userSearch) async {
    final db = await DBHelper.database();
    var response = db
        .query("wordbook", where: 'langFullWord = ?', whereArgs: [userSearch]);
    return response;
  }

  static Future myfavWord(var id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.update("wordbook", data, where: '_id = ?', whereArgs: [id]);
  }

  static Future getFavByOne() async {
    final db = await DBHelper.database();
    return db.rawQuery("SELECT * FROM wordbook WHERE Fav = '1' ");
  }
}
