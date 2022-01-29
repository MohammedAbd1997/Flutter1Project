import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/models/task.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static DatabaseHelper databaseHelper = DatabaseHelper._();

  Database database;

  /// table of tasks
  static final String TableName1 = 'tasks';
  static final String taskId = 'taskId';
  static final String title = 'title';
  static final String Description = 'Description';
  static final String isComplete = 'isComplete';
  static final String time = 'time';
  static final String day = 'day';
  static final String color = 'color';
  static final String FK_tasks_category = 'FK_tasks_category';

  /// table of catagory
  static final String TableName2 = 'Catagory';
  static final String CatagoryID = 'Catagoryid';
  static final String titlecatagory = 'titlecatagory';
  static final String numoftask = 'numoftask';
  static final String Color = 'Color';
  static final String Icon = 'Icon';


  initDatabase() {
    connectToDatabase();
  }


  connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String databasePath = directory.path + '/tasks.db';
    database = await openDatabase(databasePath, version: 1, onCreate: (db, v) {
      db.execute('''
      CREATE TABLE $TableName2
      ($CatagoryID INTEGER PRIMARY KEY AUTOINCREMENT, $titlecatagory TEXT, $numoftask INTEGER, $Icon TEXT, $Color TEXT )
      ''');

      db.execute('''
      CREATE TABLE $TableName1 (
      $taskId INTEGER PRIMARY KEY AUTOINCREMENT,
      $title TEXT,
      $Description TEXT,
      $isComplete INTEGER,
      $time TEXT,
      $day TEXT,
      $color TEXT,
      $FK_tasks_category TEXT
      )
      ''');
    });
  }

  /// tasks methods
  Future<List<Task>> getAllTasks() async {
    List<Map<String, Object>> data = await database.query(TableName1);
    List<Task> tasks = data.map((Map map) {
      return Task.fromMap(map);
    }).toList();
    //log(data.toString());
    return tasks;
  }

  Future<int> insertNewTask(Task task) async {
    int rowCount = await database.insert(TableName1, task.toMap());
    log('$rowCount');
    return rowCount;

  }

  updateOneTask(Task task) async {
    database.update(TableName1, task.toMap(),
        where: '$taskId=?', whereArgs: [task.taskId]);
  }

  deleteOneTask(Task task) async {
   int number = await database.delete(TableName1, where: '$taskId=?', whereArgs: [task.taskId]);
    log(number.toString());
  }

  /// category methods

  Future<List<Category>> getAllCatagory() async {
    List<Map<String, Object>> data = await database.query(TableName2);
    List<Category> category = data.map((Map map) {
      return Category.fromMap(map);
    }).toList();
   // log(data.toString());
    return category;
  }

  Future<int> insertNewCategory(Category category) async {
    int rowCount = await database.insert(TableName2, category.toMap());
    return rowCount;
  }

  updateOneCategory(Category category) async {
    database.update(TableName2, category.toMap(),
        where: '$CatagoryID=?', whereArgs: [category.Catagoryid]);
  }

  deleteOneCategory(Category category) async {
    database.delete(TableName2, where: '$CatagoryID=?', whereArgs: [category.Catagoryid]);
  }

  deleteall() async {
    database.delete(TableName2);
  }
}
