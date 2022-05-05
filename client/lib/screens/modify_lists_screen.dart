import 'package:flutter/material.dart';

class ModifyListScreen extends StatefulWidget {
  final String action;
  ModifyListScreen({required this.action});

  @override
  _ModifyListScreenState createState() => _ModifyListScreenState();
}

class _ModifyListScreenState extends State<ModifyListScreen> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
          onPressed: () {},
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
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "List Name",
                      labelStyle: TextStyle(
                        color: Colors.orange
                      ),
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
                    onPressed: () {},
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    color: Theme.of(context).secondaryHeaderColor,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white
                        )
                      ),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Theme.of(context).primaryColor
                        ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
