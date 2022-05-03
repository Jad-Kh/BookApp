import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../screens/home_screen.dart';
import '../screens/lists_screen.dart';

class BottomNavbar extends StatefulWidget {
  int currentTab;
  BottomNavbar({required this.currentTab});

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
    @override
    Widget build(BuildContext context) {
      User user = Provider.of<AuthProvider>(context).user;
      return Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: BottomNavigationBar(
          currentIndex: widget.currentTab,
          onTap: (int value) {
            setState(() {
              widget.currentTab = value;
            });
            if(value == 0)
              Navigator.push(
                context, new MaterialPageRoute(builder: (context) => HomeScreen())
              );
            if(value == 3)
              Navigator.push(
                context, new MaterialPageRoute(builder: (context) => ListsScreen())
              );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: widget.currentTab == 0 ? Theme.of(context).primaryColor : Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: widget.currentTab == 1 ? Theme.of(context).primaryColor : Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: widget.currentTab == 2 ? Theme.of(context).primaryColor : Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Profile",            
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                color: widget.currentTab == 3 ? Theme.of(context).primaryColor : Theme.of(context).secondaryHeaderColor,
                size: 30.0,
              ),
              label: "Lists",
            ),
          ],
        ),
      );
    }
}