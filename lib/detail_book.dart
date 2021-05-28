import 'package:bookbox/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/book.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailBook extends StatefulWidget {
  final String book;
  // final String title;
  DetailBook({Key key, this.book}) : super(key: key);
  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  // String title, brief, author, publisher, image;
  // int volumn;
  String title, image, author, brief, publisher;
  // widget.book;

  List volumn = [];
  List checked = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void checkbook(index) {
    setState(() {
      print('clicked');
      if (checked[index] == true) {
        checked[index] = false;
        print('changed to false');
      } else {
        checked[index] = true;
        print('changed to true');
      }
    });
  }

  Future<bool> getData() async {
    await firestore
        .collection('Books')
        .where('code', arrayContainsAny: [widget.book])
        .get()
        .then((QuerySnapshot snapshot) => {
              if (snapshot.docs.isNotEmpty)
                {
                  snapshot.docs.forEach((doc) {
                    Map data = doc.data();
                    String code = data["code"][0];
                    volumn = data["volumn"];
                    title = doc.id;
                    image =
                        'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/${code}.JPG';
                  })
                }
            });
    await firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        checked = [];
        Map data = documentSnapshot.data();
        data["owned_book"].forEach((ownvol) {
          if (ownvol["name"] == title) {
            volumn.forEach((vol) {
              if (ownvol["on_hand"].contains(vol)) {
                checked.add(true);
              } else {
                checked.add(false);
              }
            });
          }
        });
      } else {
        print('Document does not exist on the database');
      }
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == true && title != null) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book),
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/wood.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          Row(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 0, 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                border: Border.all(
                  color: Colors.brown,
                  width: 5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(image, fit: BoxFit.fill),
              ),
              alignment: Alignment.center,
              constraints:
                  BoxConstraints.tightForFinite(height: 250, width: 180),
            ),
            Container(
              height: 250,
              width: 175,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(right: 0, left: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.brown,
                    width: 5,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(text: 'ชื่อเรื่อง '),
                      TextSpan(
                          text: ': $title',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(text: 'ผู้แต่ง '),
                      TextSpan(
                          text: ': $author',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(text: 'สำนักพิมพ์ '),
                      TextSpan(
                          text: ': $publisher',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ]))),
                  )
                ],
              ),
            )
          ]),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.centerLeft,
            child: Text('เรื่องย่อ : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$brief',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.centerLeft,
            child: Text('รายการหนังสือทั้งหมด : ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                )),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1 / 1.5),
              itemCount: volumn.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: ClipRRect(
                      child: Container(
                          child: Stack(
                    fit: StackFit.loose,
                    alignment: AlignmentDirectional.center,
                    children: [
                      new Positioned.fill(
                        child: checked[index] == true
                            ? SvgPicture.asset("assets/icons/book_green.svg")
                            : SvgPicture.asset("assets/icons/book_grey.svg"),
                      ),
                      Positioned(

                          top: 34,
                          child: Text(volumn[index],
                              style: TextStyle(fontSize: 36)))
                    ],
                  ))),
                  onTap: () {
                    checkbook(index);
                  },
                );
              },
            ),
          ),
        ]),
      )),
    );
  }
}
