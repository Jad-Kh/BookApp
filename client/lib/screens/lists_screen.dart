import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/list_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/lists_provider.dart';
import '../widgets/list_carousel.dart';
import 'modify_lists_screen.dart';

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
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Lists',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ModifyListScreen(action: "add"),
                            ),
                          ),
                      child: Text(
                        'New List',
                        style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 35.0),
            for (UserList list in lists) ListCarousel(list: list),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModifyListScreen(action: "delete"),
                    ),
                  ),
                  child: Container(
                    height: 50.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, left: 20.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ModdifyListScreen {}
