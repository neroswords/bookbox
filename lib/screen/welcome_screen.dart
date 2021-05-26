import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Welcome to Bookbox Application", 
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
              ),
              _logo(),
              _loginBtn(),
              _signupBtn()
            ],
          ),
        ),
      ),
    );
  }



Widget _logo() {
  return Container(
    margin: EdgeInsets.only(top: 100),
    child: Stack(
      // overflow: Overflow.visible,
      children: [
        Positioned(
            child: Container(
              width: 100,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff008FFF),
              ),
            )
        ),
      ],
    )
  );
}

Widget _loginBtn() {
  return Container(
    width: double.infinity,
    // margin: EdgeInsets.only(bottom: 50),
    decoration: BoxDecoration(
      color: Color(0xff008FFF),
      borderRadius: BorderRadius.all(Radius.circular(50)),
      boxShadow: [
        BoxShadow(
        color: Color(0x60008FFF),
          blurRadius: 10,
          offset: Offset(0,5),
          spreadRadius: 0,
      ), ]

    ),
    child: FlatButton(
      onPressed: () {Get.toNamed('/login');},
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "LOG IN",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    ),
  );
}

Widget _signupBtn() {
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  return Container(
    width: double.infinity,
    // margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(50)),
      border : Border.all(width: 1.0, color: const Color(0x60008FFF)),
      boxShadow: [
        BoxShadow(
        // color: Color(0x60008FFF),
          // blurRadius: 10,
          // offset: Offset(0,1),
          // spreadRadius: 0,
      ), ]

    ),
    child: FlatButton(
      onPressed: () {Get.toNamed('/register');},
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "SIGN UP",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: 3,
          ),
        ),
      ),
      
    ),
  );
}

}