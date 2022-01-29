import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ui/Data/dummydata.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/provider/categoryprovider.dart';

class AddCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFF649dfe),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_rounded))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, x) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 85,
              ),
              Text(
                '''  Create 
  New Category''',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 55),
                        width: 250,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Colors.grey.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle),
                        child: Row(children: [
                          Icon(Icons.category),
                          SizedBox(
                            width: 20,
                          ),
                          DropdownButton<Category>(
                            alignment: Alignment.center,
                            hint: provider.value == null
                                ? Text(
                              'Select Category',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )
                                : Text(
                              provider.value,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            items: data.map((Category value) {
                              return DropdownMenuItem<Category>(
                                value: value,
                                child: Text(value.titlecatagory),
                              );
                            }).toList(),
                            onChanged: (value) {
                              provider.value = value.titlecatagory;
                              provider.category = value;
                              provider.notifyListeners();
                            },
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          provider.isValidInsertCategory(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            height: 50,
                            width: 300,
                            child: Text(
                              'Create Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}