import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/provider/categoryprovider.dart';
import 'package:todo_ui/provider/databaseprovider.dart';
import 'package:todo_ui/screens/AddNewCategory/newcategory.dart';
import 'package:todo_ui/screens/detail/details.dart';

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<CategoryProvider>(
      builder: (context, provider, x) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
              itemCount: provider.allCategory.length == 0
                  ? provider.allCategory.length + 1
                  : provider.allCategory.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => provider.allCategory.length == 0
                  ? addCategoryWidget(provider)
                  : taskWidget(provider.allCategory[index])),
        );
      },
    );
  }

  Widget addCategoryWidget(CategoryProvider provider) {
    return InkWell(
      onTap: () {

        RouterClass.routerClass.pushToSpecificScreenUsingWidget(AddCategory());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              color: Color(0xFF649dfe),
              size: 65,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Add List',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget taskWidget(Category category) {
    IconData icondata =
        IconData(int.parse(category.Icon), fontFamily: 'MaterialIcons');
    Color color = Color(int.parse(category.Color));

    return Consumer2<CategoryProvider,DatabaseProvider>(builder: (context, categoryprovider,databaseProvider, x) {
      return GestureDetector(
        onTap: () {
          RouterClass.routerClass.pushToSpecificScreenUsingWidget(Details(category));
          databaseProvider.getspacificTask(category);

          log(category.numoftask.toString());
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(
                  icondata,
                  color: color,
                  size: 35,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                category.titlecatagory,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                category.numoftask.toString() + ' Task Left',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _TaskStatus(Color bdColor, Color txColor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: bdColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: TextStyle(color: txColor),
      ),
    );
  }
}


