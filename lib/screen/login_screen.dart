import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bookbox login",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: Color(0xFFfafafa),
            width: double.infinity,
            child: Column(
              children: [
                // _logo(),
                _logoText(),
                _inputField(
                    Icon(Icons.person_outline,
                        size: 30, color: Color(0xffA6B0BD)),
                    "Email",
                    false),
                _inputField(
                    Icon(Icons.lock_outline,
                        size: 30, color: Color(0xffA6B0BD)),
                    "Password",
                    true),
                _loginBtn(),
                _dontHaveAcnt(),
                _signUp(),
              ],
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
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xff000912),
          ),
        ),
        onChanged: (value) {
          if (isPassword) {
            setState(() {
              _password = value.trim();
            });
          } else {
            setState(() {
              _email = value.trim();
            });
          }
        },
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

  Widget _signUp() {
    return FlatButton(
      onPressed: () {
        Get.toNamed('/register');
      },
      child: Text(
        "SIGN UP NOW",
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

  Widget _dontHaveAcnt() {
    return Text(
      "Don't have an account?",
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Color(0xffA6B0BD),
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _loginBtn() {
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
            UserCredential userCredential = await auth
                .signInWithEmailAndPassword(email: _email, password: _password);
            Get.toNamed('/profile');
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('Wrong password provided for that user.');
            }
          }
        },
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "LOG IN",
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

  Widget _logoText() {
    return Container(
        margin: EdgeInsets.only(top: 70, bottom: 50),
        child: Text(
          "Login",
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

// Widget _terms() {
//   return Container(
//     padding: EdgeInsets.only(top: 10, bottom: 18),
//     child: FlatButton(
//       onPressed: () => {print("Terms pressed.")},
//       child: Text(
//         "Terms & Conditions",
//         style: GoogleFonts.montserrat(
//           textStyle: TextStyle(
//             color: Color(0xffA6B0BD),
//             fontWeight: FontWeight.w400,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget _logo() {
//   return Container(
//     margin: EdgeInsets.only(top: 100),
//     child: Stack(
//       // overflow: Overflow.visible,
//       children: [
//         Positioned(
//             child: Container(
//               // width: 100,
//               // height: 100,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xff008FFF),
//               ),
//             )
//         ),
//       ],
//     )
//   );
// }