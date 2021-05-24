import 'package:bookbox/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/login_screen.dart';
import 'package:bookbox/register_screen.dart';
import 'package:bookbox/welcome_screen.dart';
import 'package:get/get.dart';

import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        home: WelcomeScreen(),
        getPages: [
          GetPage(
            name: '/welcome',
            page: () => WelcomeScreen(),
          ),
          GetPage(
            name: '/register',
            page: () => RegisterScreen(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
          ),
        ]);
  }
}
