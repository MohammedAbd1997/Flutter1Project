import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_ui/Router/router.dart';
import 'package:todo_ui/screens/home/home.dart';

class SplachScreen extends StatefulWidget {
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  NavigationFunction(context) async {
    await Future.delayed(Duration(milliseconds: 3000));
  RouterClass.routerClass.pushReplaceToSpecificScreenUsingWidget(HomePage());
  }

  @override
  void initState() {
    super.initState();
    NavigationFunction(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100,),
          Center(child: Lottie.asset('assets/animations/list.json',width: 300,height: 300)),
          SizedBox(height: 100,),
          Text('Reminder made simple',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blueAccent,fontFamily: 'assets/fonts/bold.ttf' ),),
          SizedBox(height: 15,),
          Text('Easy to Reminder your Task ',style: TextStyle(fontSize: 24,color: Colors.green,fontFamily: 'assets/fonts/bold.ttf' ),),
          Text('Write Your Task Now !! ',style: TextStyle(fontSize: 24,color: Colors.green,fontFamily: 'assets/fonts/bold.ttf' ),)
        ],
      ),

    );
  }
}
