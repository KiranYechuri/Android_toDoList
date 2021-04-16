import 'dart:io';

import 'package:flutter_todolist/models/to_do_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  String tableName = "ToDoListTable";
  String id = "id";
  String title = "title";
  String status = "status";
  String description = "description";
  String date = "date";

  static DatabaseHelper _databaseHelper; //Singleton object

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  //Create a database
  Database _database; //Singleton Object

  get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //initialize Database path
  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "my_toDO_List.db";
    return await openDatabase(path, version: 1, onCreate: create);
  }

  create(Database database, int version) async {
    return await database.execute(
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT , $title TEXT, $description TEXT, $status TEXT, $date TEXT )");
  }

  Future<int> insert(ToDoModel toDoModel) async {
    Database database = await this.database;
    var results = database.insert(tableName, toDoModel.convertModelToMap());
    print('Inserted Results $results');
    return results;
  }

  // ignore: missing_return
  Future<List<Map<String, dynamic>>> getDataInMap() async {
    Database database = await this.database;
    database.query(tableName);
  }

  Future<List<ToDoModel>> getModelsFromMapList() async {
    List<Map<String, dynamic>> mapList = await getDataInMap();
    List<ToDoModel> toDoListModel = [];
    print('Maplist Length $mapList');
    for (int i = 0; i < mapList.length; i++) {
      toDoListModel.add(ToDoModel.fromMap(mapList[i]));
    }
    return toDoListModel;
  }
}
