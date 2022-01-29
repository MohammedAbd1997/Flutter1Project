import 'package:flutter/material.dart';

class Task {
  int taskId;
  String title;
  String Description;
  String time;
  String day;
  String color;
  bool isComplete;
  String FK_tasks_category;

  Task(
      {this.taskId,
        this.title,
        this.Description,
        this.time,
        this.day,
        this.color,
        this.isComplete = false,
        this.FK_tasks_category});

  Task.fromMap(Map map) {
    this.taskId = map['taskId'];
    this.title = map['title'];
    this.Description = map['Description'];
    this.time = map['time'];
    this.day = map['day'];
    this.color = map['color'];
    this.FK_tasks_category = map['FK_tasks_category'];
    this.isComplete = map['isComplete'] == 1 ? true : false;

  }

  toMap() {
    return {'title': this.title,'Description': this.Description,'time': this.time,'day': this.day,'color': this.color,'FK_tasks_category': this.FK_tasks_category, 'isComplete': this.isComplete ? 1 : 0};
  }
}
