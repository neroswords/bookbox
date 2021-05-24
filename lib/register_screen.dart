import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "bookbox register",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: Color(0xFFfafafa),
              width: double.infinity,
              child: Column(
                children: [
                  _logoText(),
                  _inputField(Icon(Icons.person_outline,size: 30,color: Color(0xffA6B0BD)),
                  "Email",
                    false
                  ),
                  _inputField(Icon(Icons.lock_outline,size: 30,color: Color(0xffA6B0BD)),
                      "Password",
                      true
                  ),
                   _inputField(Icon(Icons.lock_outline,size: 30,color: Color(0xffA6B0BD)),
                      "Comfirm Password",
                      true
                  ),
                  _signupBtn(),
                  _HaveAcnt(),
                  _login(),
                ],
              ),
            ),
        ),
        ),
      );

  }
}

Widget _login() {
  return FlatButton(
    onPressed: () {Get.toNamed('/login');},
    child: Text(
      "LOGIN NOW",
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Color(0xFF008FFF),
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _HaveAcnt() {
  return Text(
    "Have an account?",
    style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Color(0xffA6B0BD),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}

Widget _signupBtn() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20, bottom: 50),
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
      onPressed: () => {print('Sign in pressed.')},
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        "SIGN UP",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    ),
  );
}

Widget _inputField(Icon prefixIcon, String hintText, bool isPassword) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 25,
          offset: Offset(0,5),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: EdgeInsets.only(bottom: 20),
    child: TextField(
      obscureText: isPassword,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffA6B0BD),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: 75,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget _logoText() {
  return Container(
    margin: EdgeInsets.only(top:70, bottom: 50),
    child: Text(
      "Sign up",
      style: GoogleFonts.nunito(
        textStyle: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w800,
          color: Color(0xff000912),
          letterSpacing: 2,
        ),
      ),
    )
  );
}

