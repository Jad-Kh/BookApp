import 'package:client/screens/profile_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/widgets/book_list.dart';
import 'package:client/widgets/book_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import '../providers/book_provider.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  List<Book> magazineslist = [];
  List<Book> latestlist = [];
  List<Book> typeslist = [];
  var isbns = ["1594866260", "0520221524", "0689852185", "034546205X"];
  Future initializeBooks() async {
    var magazinesResponse = await Dio().get('http://10.0.2.2:5050/api/books/magazines');
    var latestResponse = await Dio().get('http://10.0.2.2:5050/api/books/newest');
    for (var item in magazinesResponse.data) {
      Book newBook = Book.fromJson(item);
      magazineslist.add(newBook);
    }
    ;
    for (var item in latestResponse.data) {
      Book newBook = Book.fromJson(item);
      latestlist.add(newBook);
    }
    ;
    for (var isbn in isbns) {
      var typesResponse = await Dio().get('http://10.0.2.2:5050/api/books/' + isbn);
      Book newBook = Book.fromJson(typesResponse.data[0]);
      typeslist.add(newBook);
    }
    ;
    Provider.of<BookProvider>(context, listen: false)
            .getBooks(magazineslist, latestlist, typeslist);
  }
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
    initializeBooks();
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
                  Container(
                    height: 25.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            width: 23.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 190, 117, 48),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              FontAwesomeIcons.coins,
                              size: 13.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            currentUser.points.toString() + ' Points',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 50.0,
                    width: 320.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).secondaryHeaderColor,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 35.0,
                                child: Icon(
                                  FontAwesomeIcons.bookOpen,
                                  size: 20.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                'Library',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 35.0,
                                child: Icon(
                                  Icons.person,
                                  size: 22.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                width: 35.0,
                                child: Icon(
                                  Icons.people,
                                  size: 22.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                'Friends',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            DestinationCarousel(user: currentUser),
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
      bottomNavigationBar: BottomNavbar(currentTab: 0),
    );
  }
}
