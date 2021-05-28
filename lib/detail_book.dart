import 'package:bookbox/BottomBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bookbox/book.dart';

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
            // image: DecorationImage(
            //   image: NetworkImage(
            //       "https://media.istockphoto.com/photos/old-vintage-treasure-map-nautical-theme-background-picture-id501932644?k=6&m=501932644&s=170667a&w=0&h=ihgbCeJkKbmEwqWw0tr9NaIQXjkXZgAcFMZ2zWcFJiw="),
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Column(children: [
          Row(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 0, 30),
              decoration: BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/wood_bg.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5.0,
                        blurRadius: 10)
                  ],
                  color: Colors.white),
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
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/wood_bg.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.circular(40.0),
                  // boxShadow: [
                  //   BoxShadow(
                  //       color: Colors.grey.withOpacity(0.2),
                  //       spreadRadius: 5.0,
                  //       blurRadius: 10)
                  // ],
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(

                            // style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(text: 'ชื่อเรื่อง '),
                          TextSpan(
                              text: ': $title',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(
                            // style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(text: 'ผู้แต่ง '),
                          TextSpan(
                              text: ': $author',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(
                            // style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
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
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.grey[200],
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
                // color: Colors.grey[200]
                ),
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text('\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$brief',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.grey[200],
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
                  crossAxisCount: 5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 30,
                  childAspectRatio: 1 / 1.5),
              itemCount: volumn.length,
              itemBuilder: (context, index) {
                // Book mybook = _mybook[index];
                return InkWell(
                  child: ClipRRect(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 10)
                        ],
                        color: checked[index] == true
                            ? Color(0x1F000000)
                            : Color(0xFF00C853),
                      ),
                      child: Text(volumn[index],
                          style: TextStyle(fontSize: 50, color: Colors.white)),
                    ),
                  ),
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
