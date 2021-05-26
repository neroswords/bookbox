import 'package:flutter/material.dart';
import 'book.dart';
import 'package:bookbox/detail_book.dart';
import 'package:bookbox/BottomBar.dart';
import 'package:search_widget/search_widget.dart';
import 'package:get/get.dart';



class MyBook extends StatefulWidget {
  

  _MyListPageState createState() => _MyListPageState();
}


class _MyListPageState extends State<MyBook> {

_appBar(height) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height+80 ),
    child: Stack(
      children: <Widget>[
        Container(     // Background
          child: Center(
            child: Text("My Book", style: TextStyle(fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'RobotoMono'),),),
          color:Theme.of(context).primaryColor,
          height: height+75,
          width: MediaQuery.of(context).size.width,
        ),

        Container(),   // Required some widget in between to float AppBar

        Positioned(    // To take AppBar Size only
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(Icons.menu, color: Theme.of(context).primaryColor,),
            primary: false,
            title: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Theme.of(context).primaryColor), onPressed: () {},),
              IconButton(icon: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
                onPressed: () {},)
            ],
          ),
        )

      ],
    ),
  );


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
      appBar: _appBar(AppBar().preferredSize.height),
      
      body: Container(

      


        
        // padding: EdgeInsets.fromLTRB(0.0, 20, 0.0, 0),
        
        child: GridView.builder(
          
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 15 , mainAxisSpacing: 30, childAspectRatio : 0.8/1.2),
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
              
              // onTap: () {Get.toNamed('/DetailBook/$mybook.no',arguments: mybook);},
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

 