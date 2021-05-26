import 'package:bookbox/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookbox/BottomBar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      print(auth.currentUser);
    }
    return Scaffold(
        body: Center(
            child: FlatButton(
                child: Text('Logout'),
                onPressed: () {
                  auth.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                })),
        // bottomNavigationBar: BottomBar(index : 3)
        );
  }
}
