import 'package:bookbox/screen/barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/My_book.dart';
import 'package:bookbox/screen/profile_screen.dart';
import 'package:bookbox/detail_book.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BottomBar extends StatefulWidget {
  // int index;
  // BottomBar(Key key) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    MyBook(),
    DetailBook(),
    ScannerScreen(),
    ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    // _selectedIndex = widget.index;
    return new Scaffold(
        body: _children[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage(
                    'assets/images/iconfinder_office-04_809571.png')),
                label: 'My Book',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded, size: 30),
                label: 'Add Book',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/iconfinder_finance-10_808669.png'),
                  size: 25,
                ),
                label: 'Scan Barcode',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                      'assets/images/iconfinder_icons_user2_1564535.png'),
                  size: 25,
                ),
                label: 'Profile',
                backgroundColor: Colors.white),
          ],
          currentIndex: _selectedIndex,
          elevation: 0.5,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ));
  }
}
