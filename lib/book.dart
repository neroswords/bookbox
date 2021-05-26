class BookList {
  String no;
  String name;
  String desc;

  BookList({this.no, this.name, this.desc});

  String getNo() => this.no;
  String getName() => this.name;
  String getDesc() => this.desc;
}

class Book {
  List volumn;
  String no;
  String name;

  Book({this.no, this.name});
}