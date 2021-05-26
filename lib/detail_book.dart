import 'package:bookbox/BottomBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/book.dart';

class DetailBook extends StatefulWidget {
  final BookList book;
  DetailBook({Key key, this.book}) : super(key: key);
  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  BookList _book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail book'),
      ),
      body: Center(child: Text(_book.name)
          // child: Image.asset(assetpath,fit: BoxFit.fill),
          ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
