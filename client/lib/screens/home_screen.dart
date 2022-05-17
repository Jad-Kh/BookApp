import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/models/list_model.dart';
import 'package:client/widgets/book_list.dart';
import 'package:client/widgets/book_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/book_provider.dart';
import '../providers/lists_provider.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  List<String> _options = ["Magazines", "Latest", "Your Types"];

  Widget _buildOption(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Text(
        _options[index],
        style: TextStyle(
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Theme.of(context).secondaryHeaderColor,
          fontSize: 19.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[    
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Good Day',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 19.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    currentUser.username,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0),
            BookCarousel(user: currentUser),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _options
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildOption(map.key),
                  )
                  .toList(),
            ),
              BookList(user: currentUser, index: _selectedIndex),
          ],
        ),
      ),
    );
  }
}
