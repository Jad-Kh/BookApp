import 'package:flutter/material.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/models/user_model.dart';
import 'package:client/widgets/book_list.dart';
import 'package:client/widgets/book_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  List<String> _options = ["Most Readers", "Latest", "Most Types"];

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
            BookList(user: currentUser),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (int value) {
            setState(() {
              _currentTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Lists",
            ),
          ],
        ),
      ),
    );
  }
}
