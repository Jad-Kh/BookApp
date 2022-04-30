import 'package:flutter/cupertino.dart';

import '../models/book_model.dart';

class BookProvider extends ChangeNotifier {
  List<Book> magazinesList = [];
  List<Book> latestList = [];
  List<Book> typesList = [];
  BookProvider();
  void getBooks(List<Book> magazinesList, List<Book> latestList, List<Book> typesList) {
    this.magazinesList = magazinesList;
    this.latestList = latestList;
    this.typesList = typesList;
    notifyListeners();
  }
}