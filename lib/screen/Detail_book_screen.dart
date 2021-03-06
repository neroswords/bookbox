import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailBook extends StatefulWidget {
  final String book;
  DetailBook({Key key, this.book}) : super(key: key);
  @override
  _DetailBookState createState() => _DetailBookState();
}

class _DetailBookState extends State<DetailBook> {
  List suplstdex, lstdex;
  String title, image, author, brief, publisher, code;

  List volumn = [];
  List checked = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateBook() {
    return firestore
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'owned_book': lstdex})
        .then((value) => print("data update"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  void checkbook(index) async {
    setState(() {
      if (checked[index] == true) {
        suplstdex.asMap().forEach((idx, ownvol) {
          if (ownvol["name"] == title) {
            lstdex[idx]['on_hand'].removeWhere((item) => item == volumn[index]);
            if (lstdex[idx]['on_hand'].isEmpty) {
              lstdex.removeWhere((item) => item["name"] == title);
            }
          }
        });
        updateBook();
        checked[index] = false;
      } else {
        if (suplstdex.isEmpty) {
          lstdex.add({
            "on_hand": [volumn[index]],
            "name": title,
            "code": code
          });
        } else {
          suplstdex.asMap().forEach((idx, ownvol) {
            if (ownvol["name"] == title) {
              lstdex[idx]['on_hand'].add(volumn[index]);
            }
            if ((idx == (suplstdex.length - 1)) && ownvol["name"] != title) {
              lstdex.add({
                "on_hand": [volumn[index]],
                "name": title,
                "code": code
              });
            }
          });
        }

        updateBook();
        checked[index] = true;
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
                    code = data["code"][0];
                    volumn = data["volumn"];
                    title = doc.id;
                    author = data["author"];
                    brief = data["desc"];
                    publisher = data["publisher"];
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
        lstdex = data["owned_book"];
        suplstdex = data["owned_book"];
        for (var i in volumn) {
          checked.add(false);
        }

        data["owned_book"].asMap().forEach((index, ownvol) {
          if (ownvol["name"] == title) {
            checked = [];
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

  Future<bool> _onwillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
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
        title: Text(title),
        backgroundColor: Color(0xFF536DFE),
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/grey_background.jpg"),
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
                  color: Colors.black,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '?????????????????????????????? \n',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ': $title',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '????????????????????? \n',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ': $author',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ]))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        child: Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: '?????????????????????????????? \n',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ': $publisher',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                      )
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
            child: Text(
              '??????????????????????????? : ',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
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
            child: Text(
              '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t$brief',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              '???????????????????????????????????????????????????????????? : ',
              style: GoogleFonts.sarabun(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
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
