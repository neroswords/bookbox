import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/book.dart';
import 'package:bookbox/screen/Detail_book_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class MyBook extends StatefulWidget {
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyBook> {
  Timer debouncer;
  TextEditingController controller = new TextEditingController();

  void navigateSecondPage(String index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailBook(book: index),),
    ).then((_) {
      setState(() {});
    });
  }

  _appBar(height) => PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "My Book",
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'RobotoMono'),
                ),
              ),
              color: Color(0xFF536DFE),
              height: height + 75,
              width: MediaQuery.of(context).size.width,
            ),
            Container(),
            Positioned(
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: AppBar(
                backgroundColor: Colors.white,
                leading: Icon(
                  Icons.search,
                  color: Color(0xFF2979FF),
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
          if (snapshot.hasData) {
            return buildlist();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildlist() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: _searchList.length != 0 || controller.text.isNotEmpty
              ? GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8 / 1.2),
                  itemCount: _searchList.length,
                  itemBuilder: (context, index) {
                    BookList mybook = _searchList[index];
                    var card = InkWell(
                        onTap: () {
                          navigateSecondPage(mybook.getNo());
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    child: Column(children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.22,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
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
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.8 / 1.2),
                  itemCount: _mybook.length,
                  itemBuilder: (context, index) {
                    BookList mybook = _mybook[index];
                    var card = InkWell(
                        onTap: () {
                          navigateSecondPage(mybook.getNo());
                        },
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    child: Column(children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.22,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
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
                )),
    );
  }

  Future<bool> getData() async {
    _mybook = [];
    await firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map data = documentSnapshot.data();
        _mybook = [];
        data["owned_book"].forEach((doc) {
          _mybook.add(
            BookList(no: doc['code'], name: doc['name'], desc: ""),
          );
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    return true;
  }
}
