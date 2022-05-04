import 'package:client/widgets/search_list.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool pressed = false;
  int searchType = 0;
  List<bool> options = [true, false, false, false];
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            color: Theme.of(context).secondaryHeaderColor,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildExpenseBotton(Icons.numbers, "ISBN", 0),
                    buildExpenseBotton(Icons.title, "Title", 1),
                    buildExpenseBotton(Icons.publish, "Publisher", 2),
                    buildExpenseBotton(Icons.person, "Author", 3),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.black),
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(Icons.search),
                          iconSize: 30,
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            pressed = true;
                            setState(() {});
                          },
                        ),
                        hintText: "Write something here...",
                        hintStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (pressed) SearchList(search: _searchController.text, index: searchType),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildExpenseBotton(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          options = [false, false, false, false];
          options[index] = true;
          searchType = index;
        });
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: options[index] ? Colors.orange : Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: options[index]
                  ? Theme.of(context).secondaryHeaderColor
                  : Colors.white,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: options[index]
                    ? Theme.of(context).secondaryHeaderColor
                    : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
