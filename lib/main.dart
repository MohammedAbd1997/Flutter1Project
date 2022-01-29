


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_ui/provider/categoryprovider.dart';
import 'package:todo_ui/provider/databaseprovider.dart';
import 'package:todo_ui/screens/SplashScreen/splashscreen.dart';
import 'package:todo_ui/screens/home/home.dart';

import 'Data/sqlhelper.dart';
import 'Router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.databaseHelper.initDatabase();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) {
            return CategoryProvider();
          },
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (context) {
            return DatabaseProvider();
          },
        ),
      ],
      child: EasyLocalization(
          supportedLocales : [ Locale ( 'en' ), Locale ( 'ar' )],
          path: 'assets/langs', // <-- change the path of the translation files
          fallbackLocale: Locale('en'),
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
      designSize: Size(411, 820),
      minTextAdapt: true,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: RouterClass.routerClass.navKey,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: SplachScreen(),



      ),
    );
  }
}