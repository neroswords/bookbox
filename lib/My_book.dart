import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'book.dart';
import 'package:bookbox/detail_book.dart';
import 'package:bookbox/BottomBar.dart';
import 'package:search_widget/search_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBook extends StatefulWidget {
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyBook> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<BookList> _mybook = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Book"),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (_mybook.length > 0) {
              return buildList();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        bottomNavigationBar: BottomBar());
  }

  Widget buildList() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0),
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 30,
            childAspectRatio: 1 / 1.5),
        itemCount: _mybook.length,
        itemBuilder: (context, index) {
          BookList mybook = _mybook[index];
          var container = Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 3.0,
                        blurRadius: 10)
                  ],
                  color: Colors.white),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBook(book: mybook),
                        ));
                  },
                  child: Image.network(
                    'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/${mybook.getNo()}.JPG',
                    fit: BoxFit.fill,
                  )
                  // child: Image.asset(mybook.image,fit: BoxFit.fill,),

                  ));
          return ClipRRect(
              borderRadius: BorderRadius.circular(20.0), child: container);
        },
      ),
    );
  }

  Future<void> getData() async {
    _mybook = [];
    await firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map data = documentSnapshot.data();
        data["owned_book"].forEach((doc) {
          _mybook.add(
            BookList(no: doc['code'], name: doc['name'], desc: ""),
          );
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
