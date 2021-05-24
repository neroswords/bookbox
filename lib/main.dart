import 'package:bookbox/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/login_screen.dart';
import 'package:bookbox/register_screen.dart';
import 'package:bookbox/welcome_screen.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
