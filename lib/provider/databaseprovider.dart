import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:todo_ui/Data/sqlhelper.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/models/task.dart';

class DatabaseProvider extends ChangeNotifier {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  DatabaseProvider() {
    getAllTasks();
  }

  String nullValidator(String value) {
    if (value.isEmpty) {
      return 'Required Field';
    }
    return null;
  }

  bool register() {
    bool isSuccess = registerFormKey.currentState.validate();
    return isSuccess;
  }

  TextEditingController controlerTitle = TextEditingController();
  TextEditingController controlerDate = TextEditingController();
  TextEditingController controlertime = TextEditingController();
  Color TaskColor;
  TextEditingController controlerDescription = TextEditingController();
  String FK_tasks_category ;
  bool isComplete = false;

  changeIsCompleteOnNewTaskScreen() {
    isComplete = !isComplete;
    notifyListeners();
  }

  List<Task> allTasks = [];
  List<Task> completeTasks = [];
  List<Task> inCompleteTasks = [];
  List<Task> spacificTaskCategory = [];
  List<Task> spacificTaskCategorynum = [];

  Category returnCategory(Category category) {
    Category newCategory = category;
    return newCategory;
  }

  fillTasksLists(List<Task> tasks) {
    allTasks = tasks;
    completeTasks = tasks.where((element) => element.isComplete).toList();
    inCompleteTasks = tasks.where((element) => !element.isComplete).toList();
    notifyListeners();
  }

  getspacificTask(Category category) async {
    List<Task> allTasks = await DatabaseHelper.databaseHelper.getAllTasks();
    spacificTaskCategory = allTasks
        .where((element) =>
    int.parse(element.FK_tasks_category) == category.Catagoryid)
        .toList();
    notifyListeners();
  }

  getspacificTasknum(Category category) async {
    List<Task> allTasks = await DatabaseHelper.databaseHelper.getAllTasks();
    spacificTaskCategorynum = allTasks
        .where((element) =>
    int.parse(element.FK_tasks_category) == category.Catagoryid && !element.isComplete)
        .toList();
   log(spacificTaskCategorynum.length.toString());
    notifyListeners();
  }

  insertNewTask(Category category) async {
       Task task = Task(title: controlerTitle.text, day: controlerDate.text,time: controlertime.text,color: TaskColor.toString()
       ,FK_tasks_category: FK_tasks_category,Description: controlerDescription.text);
    await DatabaseHelper.databaseHelper.insertNewTask(task);
    category.numoftask++;
    getAllTasks();
    RouterClass.routerClass.popFunction();
  }

  getAllTasks() async {
    List<Task> allTasks = await DatabaseHelper.databaseHelper.getAllTasks();
    fillTasksLists(allTasks);
  }

  updateTask(Task task) async {
    task.isComplete = !task.isComplete;
    await DatabaseHelper.databaseHelper.updateOneTask(task);
    getAllTasks();
  }

  deleteTask(Task task) async {
    await DatabaseHelper.databaseHelper.deleteOneTask(task);
    getAllTasks();
  }
}
