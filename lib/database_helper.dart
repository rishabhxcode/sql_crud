import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sql_crud/model.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  String tableName = 'scientist';
  String id = 'id';
  String name = 'name';
  String imageUrl = 'image_url';
  String knownFor = 'known_for';

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'science.db';
    var scienceDb = openDatabase(path, version: 1, onCreate: createDb);
    return scienceDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, $knownFor TEXT, $imageUrl TEXT)');
  }

  //GET LIST OPERATION

  Future<List<Scientist>> getScientists() async {
    List<Scientist> _scientists = [];
    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var scientist = Scientist.fromJson(element);
      _scientists.add(scientist);
    });
    return _scientists;
  }

  // INSERT OPERATTION
  Future<int> insertScientist(Scientist scientist) async {
    Database db = await this.database;
    var result = await db.insert(
      tableName,
      scientist.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('RESULT: $result');
    return result;
  }

  //UPDATE OPERATION
  Future<void> updateScientist(Scientist scientist) async {
    final db = await database;
    await db.update(
      tableName,
      scientist.toJson(),
      where: "id = ?",
      whereArgs: [scientist.id],
    );
  }

  //DELETE OPERATION
  Future<void> deleteScientist(int id) async {
    final db = await database;
    var result = await db.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return result;
  }

  //GET OPERATION
  Future<Scientist> getScientist(int id) async {
    final db = await database;
    var result = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return Scientist.fromJson(result[0]);
  }
}
