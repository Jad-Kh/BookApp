import 'dart:async';
import 'package:provider/provider.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/book_model.dart';
import '../models/list_model.dart';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import '../providers/book_provider.dart';
import '../providers/lists_provider.dart';
import '../providers/recommendation_provider.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    var response = await Dio().post("http://10.0.2.2:5050/api/auth/login",
        data: <String, String>{'email': user.email, 'password': user.password});
    Provider.of<AuthProvider>(context, listen: false)
        .getAuth(User.fromJson(response.data));
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('password', user.password);
    await prefs.setInt('recommendations', user.recommendations);
    await prefs.setInt('flag', user.flag);
    await prefs.setBool("isLoggedIn", true);
    await buildProfile(user);
    await buildRecommendation(user);
    await initializeBooks();
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  Future buildProfile(user) async {
    List<UserList> userLists = [];
    var listResponse =
        await Dio().get('http://10.0.2.2:5050/api/lists/user/' + user.email);
    for (var item in listResponse.data) {
      UserList newList = UserList.fromJson(item);
      userLists.add(newList);
    }
    ;
    Provider.of<ListProvider>(context, listen: false).getLists(userLists);
  }

  Future buildRecommendation(user) async {
    final prefs = await SharedPreferences.getInstance();
    List<Book> list = [];
    var listResponse =
        await Dio().get('http://10.0.2.2:5050/api/python/' + user.email);
    for (var item in listResponse.data) {
      Book book = Book.fromJson(item);
      list.add(book);
    }
    ;
    Provider.of<RecommendationProvider>(context, listen: false).getList(list);
    prefs.setInt('flag', 1);
  }

  List<Book> magazineslist = [];
  List<Book> latestlist = [];
  List<Book> typeslist = [];
  var isbns = ["1594866260", "0520221524", "0689852185", "034546205X"];
  Future initializeBooks() async {
    var magazinesResponse =
        await Dio().get('http://10.0.2.2:5050/api/books/magazines');
    var latestResponse =
        await Dio().get('http://10.0.2.2:5050/api/books/newest');
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
      var typesResponse =
          await Dio().get('http://10.0.2.2:5050/api/books/' + isbn);
      Book newBook = Book.fromJson(typesResponse.data[0]);
      typeslist.add(newBook);
    }
    ;
    Provider.of<BookProvider>(context, listen: false)
        .getBooks(magazineslist, latestlist, typeslist);
  }

  User user =
      User(username: "", email: "", password: "", recommendations: 6, flag: 0);

  void init() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("isLoggedIn").toString() == "true") {
      isLoading = true;
      setState(() {});
      user.username = prefs.getString('username').toString();
      user.email = prefs.getString('email').toString();
      user.password = prefs.getString('password').toString();
      user.recommendations = prefs.getInt('recommendations')!;
      user.flag = prefs.getInt('flag')!;
      Provider.of<AuthProvider>(context, listen: false).getAuth(user);
      await buildProfile(user);
      await buildRecommendation(user);
      await initializeBooks();
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => MainScreen()),
      );
    }
  }

  @override
  void initState() {
    //   TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        if (!isLoading)
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
                    "Log In",
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
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          hintText: 'Enter Email',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
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
                      obscureText: true,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          hintText: 'Enter Password',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).secondaryHeaderColor)),
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
                            "Log In",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "No Account?",
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 40.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                            child: Text(
                              " Sign up",
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
        else
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                'assets/images/Applogo.jpg',
                height: 420.0,
                width: 420.0,
                fit: BoxFit.fill,
              ),
            ),
          )
      ],
    ));
  }
}
