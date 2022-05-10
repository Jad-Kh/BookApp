import 'package:flutter/cupertino.dart';
import '../models/book_model.dart';
import '../models/list_model.dart';

class RecommendationProvider extends ChangeNotifier {
  UserList list = UserList(title: "Recommendations", items: []);
  RecommendationProvider();
  void getList(List<Book> list) {
    this.list.title = "Recommendation";
    this.list.items = list;
    notifyListeners();
  }
}