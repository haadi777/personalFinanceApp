import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:personalfinanceapp/screens/BudgetScreen.dart';
import 'package:personalfinanceapp/screens/DisplayDataScreen.dart';
import 'package:personalfinanceapp/screens/HomeScreen.dart';
import 'package:personalfinanceapp/screens/LoginScreen.dart';
import 'package:personalfinanceapp/screens/SignupScreen.dart';
import 'package:personalfinanceapp/screens/SplashScreen.dart';

import 'Notification/NotificationDialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(

      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

