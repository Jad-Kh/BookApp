import 'package:country_list_pick/country_list_pick.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController _password = TextEditingController();

  String userId = '0';
  int recommendations = 6;

  void change(user, value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('recommendations', value.toInt());
    var response =
        await Dio().get('http://10.0.2.2:5050/api/users/userId/' + user.email);
    userId = response.data;
    await Dio().put('http://10.0.2.2:5050/api/users/' + userId,
        data: {'recommendations': value});
    Provider.of<AuthProvider>(context, listen: false)
        .updateRecommendations(value);
    setState(() {});
  }

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    recommendations = prefs.getInt('recommendations')!;
  }

  void password(user, newPassword) async {
    var response =
        await Dio().get('http://10.0.2.2:5050/api/users/userId/' + user.email);
    userId = response.data;
    await Dio().put('http://10.0.2.2:5050/api/users/password/' + userId,
        data: {'password': newPassword});
    setState(() {});
  }

  void signout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.orange,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "Settings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password", user),
            buildAccountOptionRow(context, "Country", user),
            buildAccountOptionRow(context, "Recommendations", user),
            SpinBox(
              min: 3,
              max: 8,
              value: recommendations.toDouble(),
              incrementIcon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              decrementIcon: Icon(
                Icons.remove_circle_outline,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onChanged: (value) => {change(user, value)},
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                onPressed: () {
                  signout();
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                color: Colors.orange,
                child: Text("Sign Out",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              value: isActive,
              onChanged: (bool val) {},
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, User user) {
    return GestureDetector(
      onTap: () {
        if (title == "Change password") {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(title),
                  backgroundColor: Theme.of(context).secondaryHeaderColor,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _password,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(bottom: 3),
                            labelText: "New Password",
                            labelStyle: TextStyle(color: Colors.orange),
                            fillColor: Theme.of(context).primaryColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: "Enter new password",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        password(user, _password.text);
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ],
                );
              });
        } else {
          if (title == "Country") {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(title),
                    backgroundColor: Theme.of(context).secondaryHeaderColor,
                    content: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CountryListPick(
                          initialSelection: '+961',
                          onChanged: (CountryCode? code) {},
                        ),
                      ],
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            if (title == "Recommendations") {}
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ],
        ),
      ),
    );
  }
}
