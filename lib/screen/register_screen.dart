import 'package:bookbox/My_book.dart';
import 'package:bookbox/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  FirebaseAuth auth = FirebaseAuth.instance;
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email, _password, _confirmPassword;
  final auth = FirebaseAuth.instance;
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
                _inputField(
                    Icon(Icons.email_outlined,
                        size: 25, color: Color(0xffA6B0BD)),
                    "Email",
                    false,
                    false),
                _inputField(
                    Icon(Icons.lock_outline,
                        size: 25, color: Color(0xffA6B0BD)),
                    "Password",
                    true,
                    false),
                _inputField(
                    Icon(Icons.lock_outline,
                        size: 25, color: Color(0xffA6B0BD)),
                    "Comfirm Password",
                    true,
                    true),
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

  Widget _login() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
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
              offset: Offset(0, 5),
              spreadRadius: 0,
            ),
          ]),
      child: FlatButton(
        onPressed: () async {
          try {
            if (_confirmPassword == _password) {
              UserCredential userCredential =
                  await auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyBook()),
              );
            } else {
              print('The password and confirm password does not match!');
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e);
          }
        },
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

  Widget _inputField(Icon prefixIcon, String hintText, bool isPassword,
      bool isConfirmPassword) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 25,
            offset: Offset(0, 5),
            spreadRadius: -25,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        obscureText: isPassword,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xff000912),
            
          ),
        ),
        onChanged: (value) {
          if (isPassword && !isConfirmPassword) {
            setState(() {
              _password = value.trim();
            });
          } else if (isPassword && isConfirmPassword) {
            setState(() {
              _confirmPassword = value.trim();
            });
          } else {
            setState(() {
              _email = value.trim();
            });
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.0),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xffA6B0BD),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 65,
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
        margin: EdgeInsets.only(top: 70, bottom: 50),
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
        ));
  }
}
