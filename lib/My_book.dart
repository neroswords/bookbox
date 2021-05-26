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
  MyBook({Key key, this.title}) : super(key: key);
  final String title;
  _MyListPageState createState() => _MyListPageState();
}

class _MyListPageState extends State<MyBook> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // List<Book> _mybook = [
    //   Book('111111', 'koladon sathiskun1', 'assets/testimage/2.jpg'),
    // ];
    List<Book> _mybook = [];
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection("Books")
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((doc) {
    //     _mybook.add(Book(doc['code'][0], doc[''], doc['code'][0]));
    //   });
    // });
    firestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map data = documentSnapshot.data();
        data["owned_book"].forEach((doc) {
          _mybook.add(
            Book(no: doc['code'], name: doc['name'], desc: ""),
          );
          // _mybook.add(Book(doc['code'], doc['name'], ""));
        });
      } else {
        print('Document does not exist on the database');
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
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
              Book mybook = _mybook[index];
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
                        'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/9786164476592.JPG',
                        fit: BoxFit.fill,
                      )
                      // child: Image.asset(mybook.image,fit: BoxFit.fill,),

                      ));
              return ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), child: container);
            },
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}

// class GetUserbooks extends StatelessWidget {
//   final String documentId;

//   GetUserbooks(this.documentId);

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');

//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(FirebaseAuth.instance.currentUser.uid).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data.exists) {
//           return Text("Document does not exist");
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data.data();
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }

//         return Text("loading");
//       },
//     );
//   }
// }
