import 'package:bookbox/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookbox/component/profilemenu.dart';
import 'package:bookbox/screen/termofservice_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "Profile",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: 'RobotoMono'
                    ),
                  ),
                ),
              ),
              color: Color(0xFF536DFE),
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),

            Container(),
          ],
        ),
      );

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              _proflieimage(),
              ProfileMenu(
                text: "Term Of Service",
                icon: "assets/icons/Question mark.svg",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermOfService()),
                  );
                },
              ),
              _logoutBtn(),
            ],
          ),
        ),
      );
    
  }

  Widget _proflieimage() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Stack(
          clipBehavior: Clip.none, fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(720),
              child : Image.asset('assets/icons/reader.png')
            )
          ],
        ),
      ),
    );
  }
  Widget _logoutBtn() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
          }),
    );
  }
}
