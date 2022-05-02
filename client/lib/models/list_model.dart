import 'book_model.dart';

class UserList {
  String title;
  String userId;
  List<Book> items;

  UserList({
    required this.title,
    required this.userId,
    required this.items,
  });

  factory UserList.fromJson(Map<String, dynamic> json) {
    var listsObj = json['items'];

    return UserList(
      title: json['username'],
      userId: json['email'],
      items: new List<Book>.from(listsObj),
    );
  }
} 