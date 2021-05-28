import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/detail_book.dart';
import 'package:bookbox/BottomBar.dart';
import 'package:search_widget/search_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../book.dart';
import 'dart:async';

class AddBook extends StatefulWidget {
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBook> {
  Timer debouncer;
  TextEditingController controller = new TextEditingController();

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              // Background
              child: Center(
                child: Text(
                  "My Book",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'RobotoMono'),
                ),
              ),
              color: Theme.of(context).primaryColor,
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),

            Container(), // Required some widget in between to float AppBar

            Positioned(
              // To take AppBar Size only
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
                primary: false,
                title: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: onSearchTextChanged,
                ),
              ),
            )
          ],
        ),
      );

  onSearchTextChanged(String text) async => debounce(() async {
        _searchList = [];
        if (text.isEmpty) {
        } else {
          _searchList = [];
          _mybook.forEach((mybook) {
            if (mybook.name.toLowerCase().contains(text.toLowerCase())) {
              _searchList.add(mybook);
              print('after $text');
            }
          });
        }
        setState(() {});
        print('$_searchList');
      });

  List<BookList> _searchList = [];
  List<BookList> _mybook = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (_mybook.length > 0) {
            return buildlist();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          scanBarcodeNormal();
        },
        label: const Text('Add With Barcode'),
        icon: ImageIcon(
          AssetImage('assets/images/iconfinder_finance-10_808669.png'),
          size: 25,
        ),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget buildlist() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: _searchList.length != 0 || controller.text.isNotEmpty
            ? GridView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8 / 1.2),
                itemCount: _searchList.length,
                itemBuilder: (context, index) {
                  BookList mybook = _searchList[index];
                  var card = InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailBook(book: mybook.getNo()),
                            ));
                      },
                      child: Column(children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                ),
                              ),
                              child: Column(children: [
                                Container(
                                    height: 179,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                      ),
                                    ),
                                    child: Image.network(
                                      'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/${mybook.getNo()}.JPG',
                                      fit: BoxFit.fill,
                                    )),
                                Container(
                                    child: Text(mybook.name,
                                        overflow: TextOverflow.ellipsis))
                              ]),
                            ),
                          ],
                        )
                      ]));

                  return ClipRRect(child: card);
                },
              )
            : GridView.builder(
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8 / 1.2),
                itemCount: _mybook.length,
                itemBuilder: (context, index) {
                  BookList mybook = _mybook[index];
                  var card = InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailBook(book: mybook.getNo()),
                            ));
                      },
                      child: Column(children: [
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                ),
                              ),
                              child: Column(children: [
                                Container(
                                    height: 179,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                      ),
                                    ),
                                    child: Image.network(
                                      'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/${mybook.getNo()}.JPG',
                                      fit: BoxFit.fill,
                                    )),
                                Container(
                                    child: Text(mybook.name,
                                        overflow: TextOverflow.ellipsis))
                              ]),
                            ),
                          ],
                        )
                      ]));

                  return ClipRRect(child: card);
                },
              ));
  }

  Future<bool> getData() async {
    _mybook = [];
    await firestore.collection('Books').get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        snapshot.docs.forEach((doc) {
          _mybook.add(
            BookList(no: doc['code'][0], name: doc.id, desc: doc['desc']),
          );
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    return true;
  }

  String _scanBarcode = 'Unknown';
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    if (barcodeScanRes != '-1') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBook(book: barcodeScanRes),
          ));
    }
  }
}
