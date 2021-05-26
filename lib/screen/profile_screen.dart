import 'package:bookbox/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        appBar: AppBar(
        title: Text("Profile"),
      ),
        body: Container(
          // padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _proflieimage(),
                // _profliemenu(),
                _logoutBtn(),
              ],),
            ) ,
          ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _proflieimage() {
   return SizedBox(
      height: 150,
      width: 150,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            // backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 55,
              width: 55,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Colors.white),
                ),
                color: Color(0xFFF5F6F9),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  // Widget _profliemenu() {
  //   return 
  // }

  Widget _logoutBtn() {
     return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 50),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            // BoxShadow(
            //   color: Color(0x60008FFF),
            //   blurRadius: 10,
            //   offset: Offset(0, 5),
            //   spreadRadius: 0,
            // ),
          ]),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "LOG OUT",
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 3,
            ),
          ),
        ),
        onPressed: () {
          auth.signOut();
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
      ),
    );
  //       body: Center(
  //           child: FlatButton(
  //               child: Text('Logout'),
  //               onPressed: () {
  //                 auth.signOut();
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => LoginScreen()),
  //                 );
  //               })),
  //       bottomNavigationBar: BottomBar());
  // }
}
}
