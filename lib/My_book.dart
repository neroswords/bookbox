import 'package:flutter/material.dart';
import 'book.dart';
import 'package:bookbox/detail_book.dart';
import 'package:bookbox/BottomBar.dart';
import 'package:search_widget/search_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MyBook extends StatefulWidget {
  
  MyBook({Key key, this.title}) : super(key: key);
  final String title;
  _MyListPageState createState() => _MyListPageState();
}


class _MyListPageState extends State<MyBook> {

  @override
  Widget build(BuildContext context) {
      
    List<Book> _mybook = [
      Book('111111','koladon sathiskun1','assets/testimage/2.jpg'),
      Book('111111','koladon sathiskun2','assets/testimage/1.png'),
      Book('111111','koladon sathiskun3','assets/testimage/3.jpg'),
      Book('111111','koladon sathiskun4','assets/testimage/4.jpg'),
      Book('111111','koladon sathiskun4','assets/testimage/2.jpg'),
      Book('111111','koladon sathiskun4','assets/testimage/3.jpg'),
      Book('111111','koladon sathiskun4','assets/testimage/2.jpg'),
      Book('111111','koladon sathiskun4','assets/testimage/3.jpg'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      body: Container(
        
        padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0),
        
        child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 15 , mainAxisSpacing: 30, childAspectRatio : 1/1.5),
          itemCount: _mybook.length,
          
          itemBuilder: (context, index){
            Book mybook = _mybook[index];
            var container = Container(
              
              decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 10
                )
              ],
              color: Colors.white
              
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=>DetailBook(book: mybook),
              )
            );
              },
              
              child : Image.network('https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/9786164476592.JPG',fit: BoxFit.fill,)
              // child: Image.asset(mybook.image,fit: BoxFit.fill,),
              
            )
              );
            return ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: container
            );
          },
        ),
      ),
      
      bottomNavigationBar: BottomBar()
        
      
    );
  }
}

 