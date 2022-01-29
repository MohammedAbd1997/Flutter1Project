import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_color_picker_wns/material_color_picker_wns.dart';
import 'package:provider/provider.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/models/task.dart';
import 'package:todo_ui/provider/categoryprovider.dart';
import 'package:todo_ui/provider/databaseprovider.dart';
import 'package:todo_ui/screens/AddNewTask/addnewtask.dart';
import 'package:todo_ui/screens/home/widgets/customtextfield.dart';

class Details extends StatelessWidget {
  Category category;

  Details(this.category);

  IconData initIcon() {
    IconData icondata =
        IconData(int.parse(category.Icon), fontFamily: 'MaterialIcons');
    return icondata;
  }

  Color initColor() {
    Color color = Color(int.parse(category.Color));
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DatabaseProvider, CategoryProvider>(
      builder: (context, dataprovider, categoryprovider, x) {
        return Scaffold(
          backgroundColor: Color(0xFF649dfe),
          appBar: AppBar(
            actions: [
              PopupMenuButton(
                  // add icon, by default "3 dot" icon
                  // icon: Icon(Icons.book)
                  itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("Add New Task"),
                  ),
                ];
              }, onSelected: (value) {
                if (value == 0) {
                  RouterClass.routerClass.pushToSpecificScreenUsingWidget(
                      AddNewTaskPage(category));
                }
              }),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          floatingActionButton: category.numoftask == 0
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF649dfe), width: 2),
                      shape: BoxShape.circle),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    onPressed: () {
                      RouterClass.routerClass.pushToSpecificScreenUsingWidget(
                          AddNewTaskPage(category));
                    },
                    child: Icon(
                      Icons.add_rounded,
                      size: 35,
                      color: Color(0xFF649dfe),
                    ),
                  ),
                )
              : Text(''),
          body: Consumer<DatabaseProvider>(
            builder: (context, provider, x) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              initIcon(),
                              size: 30,
                              color: initColor(),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          category.titlecatagory,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          ' ${category.numoftask.toString()} Tasks',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Taskwidget(
                                dataprovider.spacificTaskCategory[index],
                                category);
                          },
                          itemCount: dataprovider.spacificTaskCategory.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

Widget Taskwidget(Task task, Category category) {
  String color = task.color.substring(6, 16);
  return Consumer2<DatabaseProvider, CategoryProvider>(
    builder: (context, prov, catprov, x) {
      return Container(
        height: 120,
        margin: EdgeInsets.only(left: 5, top: 8, bottom: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(left: 55, bottom: 5),
                child: Text(task.day)),
            Row(
              children: [
                Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.lightGreen,
                    value: task.isComplete,
                    shape: CircleBorder(),
                    onChanged: (value) async {
                      await prov.updateTask(task);
                      await prov.getspacificTasknum(category);
                      int numOfTask = prov.spacificTaskCategorynum.length;
                      category.numoftask = numOfTask;
                      catprov.updateCategory(category);
                      log(numOfTask.toString() + 'Check Box');
                      prov.notifyListeners();
                    },
                  ),
                ),
                Expanded(
                  child: !task.isComplete
                      ? InkWell(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.all(6.0),
                                  title: Text("Are you sure to Delete Task ?"),
                                  actions: [
                                    TextButton(
                                      child: Text('No'),
                                      onPressed: Navigator.of(context).pop,
                                    ),
                                    TextButton(
                                      child: Text('Yes'),
                                      onPressed: () async {
                                        await prov.deleteTask(task);
                                        await prov.getspacificTask(category);
                                        await prov.getspacificTasknum(category);
                                        int numOfTask =
                                            prov.spacificTaskCategorynum.length;
                                        category.numoftask = numOfTask;
                                        Category newcategory = category;
                                        catprov.updateCategory(newcategory);
                                        RouterClass.routerClass.popFunction();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 90,
                            margin: EdgeInsets.only(right: 20),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(int.parse(color))
                                        .withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 20, right: 20),
                                          child: Text(
                                            task.title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 10, left: 20, right: 20),
                                          child: Text(
                                            '${task.time}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 15),
                                        child: Text(
                                          task.Description,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Card(
                            color: Colors.white.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 25, left: 20, right: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        task.title,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Spacer(),
                                      Text(
                                        '${task.time}',
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      task.Description,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 15),
                                    ))
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
