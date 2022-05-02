import 'package:flutter/cupertino.dart';
import '../models/list_model.dart';

class ListProvider extends ChangeNotifier {
  List<UserList> lists = [];
  ListProvider();
  void getLists(List<UserList> lists) {
    this.lists = lists;
    notifyListeners();
  }
}