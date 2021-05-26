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
        MaterialPageRoute(builder: (context) => MyBook()),
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
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/iconfinder_office-04_809571.png')),
            label: 'My Book',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded, size: 30),
            label: 'Add Book',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/iconfinder_finance-10_808669.png'),size: 25,),
            label: 'Scan Barcode',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/iconfinder_icons_user2_1564535.png'),size: 25,),
            label: 'Profile',
            backgroundColor: Colors.white),
      ],
      currentIndex: _selectedIndex,
      elevation : 0.5,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
