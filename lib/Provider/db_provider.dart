import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quiz/Models/AnsModel.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AnsDB.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Ans(' //สร้างตารามสถานที่
        'id INTEGER PRIMARY KEY,'
        'num_quiz INTEGER,'
        'time_stamp DATETIME,'
        'num_correct INTEGER,'
        'num_incorrect INTEGER,'
        'percent INTEGER,'
        'grade FLOAT,'
        'exam_duration TEXT'
        ')');
  }

  Future<List> getAns() async {
    Database db = await instance.database;
    var ansList = await db.query('Ans', orderBy: 'time_stamp');

    return ansList;
  }

  Future<List> getAnsbyID(int id) async {
    Database db = await instance.database;
    var ansList = await db.rawQuery('SELECT * FROM Ans WHERE id = ?', [id]);

    return ansList;
  }

  Future<int> add(Ans ans) async {
    Database db = await instance.database;
    return await db.insert('Ans', ans.toJson());
  }

  Future<int> removebyID(int id) async {
    Database db = await instance.database;
    return await db.rawDelete('DELETE FROM Ans WHERE id = ?', [id]);
  }

  Future<int> removeAll() async {
    Database db = await instance.database;
    return await db.delete('Ans');
  }
}
