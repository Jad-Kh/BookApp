import 'book_model.dart';

class UserList {
  String title;
  List<Book> items;

  UserList({
    required this.title,
    required this.items,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    List<Book> templist = [];
    for(var item in json['books']){
     templist.add(Book.fromJson(item));
    }

    return UserList(
      title: json['title'],
      items: templist,
    );
  }
} 