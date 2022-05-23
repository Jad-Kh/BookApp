import 'dart:async';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/login_screen.dart';
import 'package:dio/dio.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    var response = await Dio().post("http://10.0.2.2:5050/api/auth/register",
        data: <String, String>{'username': user.username,'email': user.email, 'password': user.password});
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  User user = User(
      username: "",
      email: "",
      password: "",
      recommendations: 6,
      flag: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Theme.of(context).secondaryHeaderColor),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.username),
                    onChanged: (value) {
                      user.username = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        hintText: 'Enter Username',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.email),
                    onChanged: (value) {
                      user.email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return null;
                      } else {
                        return 'Enter valid email';
                      }
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor
                    ),
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        hintText: 'Enter Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: TextEditingController(text: user.password),
                    onChanged: (value) {
                      user.password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.vpn_key,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                        hintText: 'Enter Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Theme.of(context).secondaryHeaderColor)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.red))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                  child: Container(
                    height: 50,
                    width: 400,
                    child: FlatButton(
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            save();
                          } else {
                            print("not ok");
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                    child: Row(
                      children: [
                        Text(
                          "Already have an Account?",
                          style: TextStyle(
                              color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            " Log In",
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    ));
  }
}
