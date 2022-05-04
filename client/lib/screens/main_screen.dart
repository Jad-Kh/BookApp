import 'package:client/screens/home_screen.dart';
import 'package:client/screens/lists_screen.dart';
import 'package:client/screens/search_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTab = 0;
  List<Widget> widgets = [
    HomeScreen(),
    SearchScreen(),
    Scaffold(), // Store (Google Map stuff)
    ListsScreen(),
    Scaffold(), // Settings
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[currentTab],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: currentTab,
          onTap: (int value) {
            setState(() {
              currentTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.home,
                size: 30.0,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.search,
                size: 30.0,
              ),
              label: "Search",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.book,
                size: 30.0,
              ),
              label: "Stores",            
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.list,
                size: 30.0,
              ),
              label: "Lists",
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.black,
              icon: Icon(
                Icons.settings,
                size: 30.0,
              ),
              label: "Settings",
            ),
          ],
        )
    );
  }
}