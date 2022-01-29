

import 'package:flutter/material.dart';
import 'package:todo_ui/models/category.dart';

class MyWidget extends StatelessWidget {


  Widget build(BuildContext context) {
    return new IconButton(
        // Use the MdiIcons class for the IconData
        icon: new Icon(Icons.airplanemode_on_rounded,),
        onPressed: () {
          print('Using the sword');
        });
  }
}

List<Category> data = [
  Category(titlecatagory: 'All',Icon: '0xee98',Color: '0xFF000000'),
  Category(titlecatagory: 'Work',Icon: '0xe6f2',Color: '0xFF2196F3'),
  Category(titlecatagory: 'Personal',Icon: '0xe491',Color: '0xFFFFEB3B'),
  Category(titlecatagory: 'Health',Icon: '0xf7df',Color: '0xFFF44336'),
  Category(titlecatagory: 'Travel',Icon: '0xf54c',Color: '0xFF795548'),
  Category(titlecatagory: 'Learning',Icon: '0xe0ef',Color: '0xFFef61ac'),
  Category(titlecatagory: 'Shopping',Icon: '0xe59c',Color: '0xFFd761f3'),
  Category(titlecatagory: 'Movie',Icon: '0xf8e5',Color: '0xFF8667f9'),
  Category(titlecatagory: 'Dinner',Icon: '0xf6ac',Color: '0xFFff997f'),
  Category(titlecatagory: 'Fitness',Icon: '0xe28d',Color: '0xFF60d991'),
  Category(titlecatagory: 'Home',Icon: '0xf107',Color: '0xFF00BCD4'),
  Category(titlecatagory: 'Music',Icon: '0xf851',Color: '0xFFFF4081'),
  Category(titlecatagory: 'Other',Icon: '0xf0036',Color: '0xFF607D8B'),
];

