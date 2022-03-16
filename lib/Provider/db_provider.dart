import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz/Pages/Transactions.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Ans(' //สร้างตารามสถานที่
            'id INTEGER PRIMARY KEY,'
            'time_stamp DATETIME,'
            'num_correct INTEGER,'
            'num_incorrect INTEGER,'
            'percent INTEGER,'
            'grade FLOAT,'
            'exam_duration TEXT'
            ')');
    });
  }

  Insert(Transactions data) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    //insert to the table using the new id
    var raw = await db.insert('Ans', data.toMap());
    return raw;
  }

}
