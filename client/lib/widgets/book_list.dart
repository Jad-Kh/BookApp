import 'package:client/fragments/latest_fragment.dart';
import 'package:client/fragments/magazines_fragment.dart';
import 'package:client/fragments/types_fragment.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/book_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/book_screen.dart';

class BookList extends StatefulWidget {
  final User user;
  final int index;
  BookList({required this.user, required this.index});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {

  @override
  Widget build(BuildContext context) {
    if(widget.index == 0) {
      return MagazinesFragment();
    } else
    if(widget.index == 1) {
      return LatestFragment();
    } else {
      return TypesFragment();
    } 
  }
}