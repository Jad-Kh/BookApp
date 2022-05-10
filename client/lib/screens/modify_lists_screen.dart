import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/book_model.dart';
import '../models/list_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/lists_provider.dart';

class ModifyListScreen extends StatefulWidget {
  final String action;
  final Book book;
  ModifyListScreen({required this.action, required this.book});

  @override
  _ModifyListScreenState createState() => _ModifyListScreenState();
}

class _ModifyListScreenState extends State<ModifyListScreen> {
  TextEditingController _listname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<UserList> lists = Provider.of<ListProvider>(context).lists;
    User currentUser = Provider.of<AuthProvider>(context).user;
    if (widget.action == "add") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: TextField(
                    controller: _listname,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "List Name",
                        labelStyle: TextStyle(color: Colors.orange),
                        fillColor: Theme.of(context).primaryColor,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Enter list name",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Text("Cancel",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white)),
                    ),
                    RaisedButton(
                      onPressed: () async {
                        var userId = await Dio().get(
                            'http://10.0.2.2:5050/api/users/userId/' +
                                currentUser.email);
                        var listResponse = await Dio()
                            .post('http://10.0.2.2:5050/api/lists/new', data: {
                          "title": _listname.text,
                          "userId": userId.toString()
                        });
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setInt('flag', 0);
                        Navigator.pop(context);
                      },
                      color: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    } else if (widget.action == "delete") {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Text(
              "Choose which list to delete: ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
            for(var list in lists)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        var listResponse = await Dio().delete('http://10.0.2.2:5050/api/lists/' + list.title);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setInt('flag', 0);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 25,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.orange),
                    fillColor: Theme.of(context).primaryColor,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: list.title,
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.orange,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Text(
              "Choose which list to add that book to: ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 30),
            for(var list in lists)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        List<UserList> userLists = [];
                        var listResponse = await Dio().put('http://10.0.2.2:5050/api/lists/add/' + list.title,
                            data: {"isbn": widget.book.isbn});
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setInt('flag', 0);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.remove_circle,
                        color: Theme.of(context).secondaryHeaderColor,
                        size: 25,
                      ),
                    ),
                    labelStyle: TextStyle(color: Colors.orange),
                    fillColor: Theme.of(context).primaryColor,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: list.title,
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
          ],
        ),
      );
    }
  }
}