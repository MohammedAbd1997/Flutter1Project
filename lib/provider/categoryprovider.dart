import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_ui/Data/sqlhelper.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    getAllCategory();

  }

  String value;
  Category category;

  List<Category> allCategory = [];
  List<Category> isInsert = [];

  fillTasksLists(List<Category> category) {
    allCategory = category;
    notifyListeners();
  }

  snakbarshow(BuildContext context) {
    final snackBar = SnackBar(content: Text('This Category is Add befor !!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  insertNewCategory() async {
    await DatabaseHelper.databaseHelper.insertNewCategory(category);
    RouterClass.routerClass.popFunction();
    getAllCategory();
  }

  isValidInsertCategory(BuildContext context) async {
    isInsert = await allCategory
        .where((element) => element.titlecatagory == category.titlecatagory)
        .toList();
    isInsert.isNotEmpty ? snakbarshow(context) : insertNewCategory();
  }

  getAllCategory() async {
    List<Category> allCategory =
        await DatabaseHelper.databaseHelper.getAllCatagory();
    fillTasksLists(allCategory);
  }

  updateCategory(Category category) async {
    await DatabaseHelper.databaseHelper.updateOneCategory(category);
    getAllCategory();
  }

  deleteCategory(Category category) async {
    await DatabaseHelper.databaseHelper.deleteOneCategory(category);
    getAllCategory();
  }

  deleteallCategory() async {
    await DatabaseHelper.databaseHelper.deleteall();
    getAllCategory();
  }
}
