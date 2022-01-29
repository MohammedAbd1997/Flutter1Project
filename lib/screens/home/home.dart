import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/provider/categoryprovider.dart';
import 'package:todo_ui/screens/AddNewCategory/newcategory.dart';
import 'package:todo_ui/screens/home/widgets/category.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (context, provi, x) {
      return Scaffold(
        backgroundColor: Color(0xFF649dfe),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_rounded,
                      size: 45,
                    ),
                  ),
                  accountName: Text('Mohammed'),
                  accountEmail: Text('Mohammed2022@gmail.com')),
              ListTile(
                onTap: () {
                  /*
                if (context.locale == Locale('en')) {
                  context.setLocale(Locale('ar'));
                } else {
                  context.setLocale(Locale('en'));
                }*/
                },
                title: Text('Change_Language'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              ListTile(
                onTap: () {
                  provi.deleteallCategory();
                },
                title: Text('Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Task App',
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: Builder(builder: (context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: IconButton(
                icon: Icon(
                  Icons.view_headline,
                  color: Colors.white,
                ),
                onPressed: () {
                  return Scaffold.of(context).openDrawer();
                },
              ),
            );
          }),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(15),
              child: Text(
                'Lists ',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Expanded(child: Tasks()),
          ],
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF649dfe), width: 2),
              shape: BoxShape.circle),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.white,
            onPressed: () {
              provi.value = 'Select Category';
              RouterClass.routerClass
                  .pushToSpecificScreenUsingWidget(AddCategory());
            },
            child: Icon(
              Icons.add_rounded,
              size: 35,
              color: Color(0xFF649dfe),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10)
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(
                  Icons.home_rounded,
                  size: 30,
                )),
            BottomNavigationBarItem(
                label: 'Person',
                icon: Icon(
                  Icons.person_rounded,
                  size: 30,
                )),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/avatar.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Hi, Mohammed!',
            style: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          )
        ],
      ),
      actions: [
        Icon(
          Icons.more_vert,
          color: Colors.black.withOpacity(0.7),
          size: 40,
        )
      ],
    );
  }
}
