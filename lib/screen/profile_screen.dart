import 'package:bookbox/screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookbox/BottomBar.dart';
import 'package:bookbox/component/profilemenu.dart';
import 'package:bookbox/screen/termofservice_screen.dart';
import 'package:bookbox/screen/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 20),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Text(
                  "Profile",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: height + 10,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar
          ],
        ),
      );

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      print(auth.currentUser);
    }
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(AppBar().preferredSize.height),
        body: Container(
          // padding: EdgeInsets.symmetric(vertical: 20),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                _proflieimage(),
                ProfileMenu(
                  text: "Term Of Service",
                  icon: "assets/icons/Question mark.svg",
                  press : () {
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
        ),
      ),
    );
  }

  Widget _proflieimage() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 150,
        width: 150,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            CircleAvatar(
                child: SvgPicture.asset("assets/icons/User.svg"),
                ),
            // Positioned(
            //   right: -16,
            //   bottom: 0,
            //   child: SizedBox(
            //     height: 46,
            //     width: 46,
            //     child: FlatButton(
            //       padding: EdgeInsets.zero,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(50),
            //         side: BorderSide(color: Colors.white),
            //       ),
            //       color: Color(0xFFF5F6F9),
            //       onPressed: () {},
            //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  // Widget _profliemenu() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: FlatButton(
  //       padding: EdgeInsets.all(20),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       color: Colors.red,
  //       // onPressed: press,
  //       child: Row(
  //         children: <Widget>[
  //           SvgPicture.asset(
  //             "assets/icons/Settings.svg",
  //             color: Colors.grey,
  //             width: 22,
  //           ),
  //           SizedBox(width: 20),
  //           // Expanded(child: Text(text)),
  //           Icon(Icons.arrow_forward_ios),
  //           SvgPicture.asset(
  //             "assets/icons/Settings.svg",
  //             color: Colors.grey,
  //             width: 22,
  //           ),
  //           SizedBox(width: 20),
  //           // Expanded(child: Text(text)),
  //           Icon(Icons.arrow_forward_ios),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
