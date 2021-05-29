import 'package:bookbox/screen/add_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/My_book.dart';
import 'package:bookbox/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    return new Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[MyBook(), AddBook(), ProfileScreen()]),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: [
          CustomBottomNavigationBarItem(
            icon: Icons.menu_book_rounded,
            title: "My Book",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.add_box_rounded,
            title: "Add Book",
          ),
          CustomBottomNavigationBarItem(
            icon: Icons.person_pin,
            title: "Profile",
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 600));
        },
        backgroundColor: Color(0xFF536DFE),
        itemBackgroudnColor: Color(0xFF536DFE),
      ),
    );
  }
}
