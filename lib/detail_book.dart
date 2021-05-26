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
  final String title = 'ตัวประกอบอย่างตูช่างอยู่ยากในโลกเกมจีบหนุ่ม';
  final String brief =
      'ลีออน ผู้มีอดีตชาติเป็นพนักงานเงินเดือนในญี่ปุ่น ซึ่งเกิดใหม่ในโลก “เกมจีบหนุ่ม” ที่มีดาบและเวทมนตร์ ก็พบกับความสิ้นหวังกับโลกที่ผู้หญิงเป็นใหญ่ ในโลกใบนี้ ผู้ชายมีค่าแค่ปศุสัตว์ไว้เลี้ยงดูผู้หญิง ผู้ที่เป็นข้อยกเว้น มีแค่กองกำลังหนุ่มหล่อของเจ้าชายรัชทายาทที่เป็นตัวละครให้จีบในเกมเท่านั้น ในสภาพแวดล้อมอันแสนจะไร้เหตุผลสิ้นดี ลีออนก็มีอาวุธอยู่อย่างหนึ่ง ใช่แล้ว มันคือความรู้ของเกมนี้ที่เขาถูกน้องสาวแก่แดดบังคับขู่เข็ญให้เล่นในชาติก่อน ลีออนที่เคยคิดอยากใช้ชีวิตเก็บตัวเงียบๆ ในบ้านนอก ก็หันมาใช้ความรู้นั้นต่อต้านเหล่าผู้หญิงและพวกหน้าหล่อที่ชอบทำอะไรตามใจตัวเอง นิยายแฟนตาซีของการโค่นล้มผู้อยู่เหนือกว่าอย่างสบายๆ (?) โดยพระเอกนอกรีต ได้เริ่มขึ้นแล้ว!';
  final String author = 'Mishima Yomu';
  final String publisher = 'Luckpim';
  final String image =
      'https://www.phanpha.com/sites/default/files/imagecache/product_full/images01/9786164476592.JPG';
  // widget.book;

  final List a = ['1', '2', '3', '4', '5', '6', '7', '8'];
  List checked = [true, false, false, false, false, false, false, false];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name),
      ),
      body: SingleChildScrollView(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://media.istockphoto.com/photos/old-vintage-treasure-map-nautical-theme-background-picture-id501932644?k=6&m=501932644&s=170667a&w=0&h=ihgbCeJkKbmEwqWw0tr9NaIQXjkXZgAcFMZ2zWcFJiw="),
            fit: BoxFit.cover,
          ),
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
                  image: DecorationImage(
                    image: AssetImage("assets/images/wood_bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5.0,
                        blurRadius: 10)
                  ],
                  color: Colors.white),
              // padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('ชื่อเรื่อง   : $title'),
                  ),
                  Container(child: Text('ผู้แต่ง     : $author')),
                  Container(child: Text('สำนักพิมพ์ : $publisher')),
                ],
              ),
            )
          ]),
          Container(
            decoration: BoxDecoration(
                // image : DecorationImage(
                //   image: AssetImage("assets/images/wood_bg.jpg"),
                //         fit: BoxFit.cover,
                // ),
                // border : BoxBorder.solid,
                color: Colors.grey[200]),
            // color: Colors.grey[200],
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Text('\t\t\t\t\t\t\t\t\tเรื่องย่อ : $brief',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Container(
            color: Colors.grey[200],
            alignment: Alignment.centerLeft,
            child: Text('\t\t\t\t\tรายการหนังสือทั้งหมด : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              itemCount: a.length,
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
                            ? Color(0xff7c94b6)
                            : Color(0xFFB71C1C),
                      ),
                      child: Text(index.toString(),
                          style: TextStyle(fontSize: 50)),
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
