import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/todomodel.dart';

class DBHelper {

  //Variables
  String tblTodo = "todo";
  String colID = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "Priority";
  String colDate = "date";

  ///Singleton
  static final DBHelper _dbHelper = DBHelper._internal();
  DBHelper._internal(); ///named constructor

  factory DBHelper() { //unnamed
    return _dbHelper;
  }

  static Database _db;
  ///getters
  Future<Database> get db async{
    if(_db == null) {
      _db = await initializeDB();
    }
    return _db;
  }

  ///Use Future for DB
  Future<Database> initializeDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "todos.db";
    var dbTodos = await openDatabase(
      path, version: 1, onCreate: _createDB
    );
    return dbTodos;
  }

  ///Create a database
  void _createDB (Database db, int newVersion) async {
    await db.execute(
      "CREATE TABLE $tblTodo($colID INTEGER PRIMARYKEY, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)"
    );
  }

  ///CRUD queries
  Future<int> insertTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.insert(tblTodo, todo.toMap());
    return result;
  }

  Future<List> getTodos() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblTodo ORDER BY $colPriority ASC");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT(*) FROM $tblTodo")
    );
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database db = await this.db;
    var result = await db.update(tblTodo, todo.toMap(), 
      where: "$colID = ?", whereArgs:[todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    int result;
    Database db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblTodo WHERE $colID = $id");
    return result;
  }


}