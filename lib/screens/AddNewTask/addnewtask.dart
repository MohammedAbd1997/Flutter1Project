import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:material_color_picker_wns/material_color_picker_wns.dart';
import 'package:provider/provider.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/models/category.dart';
import 'package:todo_ui/provider/categoryprovider.dart';
import 'package:todo_ui/provider/databaseprovider.dart';
import 'package:todo_ui/screens/home/widgets/customtextfield.dart';

class AddNewTaskPage extends StatelessWidget {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Category category;

  AddNewTaskPage(this.category);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<DatabaseProvider, CategoryProvider>(
      builder: (context, prov, provcategory, x) {
        return Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  RouterClass.routerClass.popFunction();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                )),
            centerTitle: true,
            title: Text(
              'Create New Task',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Form(
            key: prov.registerFormKey,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomTextfieldTitle(
                            textInputType: TextInputType.multiline,
                            validationFun: prov.nullValidator,
                            controller: prov.controlerTitle,
                            labelText: 'What are you planning ?',
                          ),
                          Container(
                              child: CustomTextfieldDec(
                                controller: prov.controlerDescription,
                                validationFun: prov.nullValidator,
                                labelText: 'DESCREPTION',
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final DateTime picked =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: selectedDate,
                                        firstDate: DateTime(2015, 8),
                                        lastDate: DateTime(2101));
                                    if (picked != null &&
                                        picked != selectedDate)
                                      selectedDate = picked;
                                    String day;
                                    switch (picked.weekday.toString()) {
                                      case '0':
                                        day = 'Mon';
                                        break;
                                      case '7':
                                        day = 'Sun';
                                        break;
                                      case '6':
                                        day = 'Sat';
                                        break;
                                      case '5':
                                        day = 'Fri';
                                        break;
                                      case '4':
                                        day = 'Thu';
                                        break;
                                      case '3':
                                        day = 'Wed';
                                        break;
                                      case '2':
                                        day = 'Thr';
                                        break;
                                      case '1':
                                        day = 'Mon';
                                        break;
                                    }
                                    String Month;
                                    switch (picked.month.toString()) {
                                      case '1':
                                        Month = 'Jan';
                                        break;
                                      case '2':
                                        Month = 'Feb';
                                        break;
                                      case '3':
                                        Month = 'Mar';
                                        break;
                                      case '4':
                                        Month = 'Apr';
                                        break;
                                      case '5':
                                        Month = 'May';
                                        break;
                                      case '6':
                                        Month = 'Jun';
                                        break;
                                      case '7':
                                        Month = 'Jul';
                                        break;
                                      case '8':
                                        Month = 'Aug';
                                        break;
                                      case '9':
                                        Month = 'Sep';
                                        break;
                                      case '10':
                                        Month = 'Oct';
                                        break;
                                      case '11':
                                        Month = 'Nov';
                                        break;
                                      case '12':
                                        Month = 'Dec';
                                        break;
                                    }
                                    prov.controlerDate.text =
                                    '${day}  ${picked.day}/${Month}/${picked.year}';
                                  },
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              CustomTextfield3(
                                validationFun: prov.nullValidator,
                                labelText: 'Date',
                                controller: prov.controlerDate,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final TimeOfDay picked_s =
                                    await showTimePicker(
                                        context: context,
                                        initialTime: selectedTime,
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return MediaQuery(
                                            data: MediaQuery.of(context)
                                                .copyWith(
                                                alwaysUse24HourFormat:
                                                false),
                                            child: child,
                                          );
                                        });

                                    if (picked_s != null &&
                                        picked_s != selectedTime)
                                      selectedTime = picked_s;

                                    prov.controlertime.text =
                                        picked_s.format(context).toString();
                                  },
                                  icon: Icon(
                                    Icons.timer,
                                    color: Colors.grey,
                                    size: 30,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              CustomTextfield3(
                                validationFun: prov.nullValidator,
                                controller: prov.controlertime,
                                labelText: 'Time',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        var Colorchoose = Colors.red;
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(6.0),
                              title: Text("title"),
                              content: MaterialColorPicker(
                                selectedColor: Colorchoose,
                                allowShades: false,
                                onMainColorChange: (color) {
                                  Colorchoose = color;
                                },
                              ),
                              actions: [
                                TextButton(
                                  child: Text('CANCEL'),
                                  onPressed: Navigator.of(context).pop,
                                ),
                                TextButton(
                                  child: Text('SUBMIT'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    prov.TaskColor = Colorchoose.shade500;
                                    prov.notifyListeners();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 10),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.color_lens_outlined,
                                    color: Colors.grey,
                                    size: 35,
                                  ))),
                          Center(
                              child: Text(
                                'Color Task',
                                style: TextStyle(
                                    color: prov.TaskColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        prov.FK_tasks_category = category.Catagoryid.toString();
                        prov.register();
                        log(prov.register().toString());
                        if (prov.register()) {
                          await prov.insertNewTask(category);
                          await prov.getspacificTask(category);
                          await prov.getspacificTasknum(category);
                          int numOfTask = prov.spacificTaskCategorynum.length;
                          category.numoftask = numOfTask;
                          Category newcategory = category;
                          provcategory.updateCategory(newcategory);
                          prov.getAllTasks();
                        }
                      },
                      child: Center(
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            height: 50,
                            width: 300,
                            child: Text(
                              'Add New Task',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}