import 'package:flutter/material.dart';
import 'package:bookbox/My_book.dart';
import 'package:bookbox/screen/profile_screen.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if (index == 0 && index != _selectedIndex) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyBook(title: 'My Book')),
      );
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1 && index != _selectedIndex) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BMIcal()),
      // );
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 2 && index != _selectedIndex) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BMIcal()),
      // );
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 3 && index != _selectedIndex) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      );
      setState(() {
        _selectedIndex = index;
      });
    }
    // setState(() {
    //   _selectedIndex = index;
    // });
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book, size: 30),
            label: 'Home',
            backgroundColor: Colors.lightBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, size: 30),
            label: 'Business',
            backgroundColor: Colors.lightBlue),
        BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_sharp, size: 30),
            label: 'School',
            backgroundColor: Colors.lightBlue),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'School',
            backgroundColor: Colors.lightBlue),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
