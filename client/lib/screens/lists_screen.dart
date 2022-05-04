import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/list_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/lists_provider.dart';
import '../widgets/list_carousel.dart';

class ListsScreen extends StatelessWidget {
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<AuthProvider>(context).user;
    List<UserList> lists = Provider.of<ListProvider>(context).lists;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Your Lists',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 35.0),
            ListCarousel(list: lists[0]),
            ListCarousel(list: lists[1]),
            ListCarousel(list: lists[2]),
          ],
        ),
      ),
    );
  }
}
