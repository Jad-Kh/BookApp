import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User user = User(username: "", email: "", password: "", points: 0, lists: [], friends: [], requests: []);
  AuthProvider();
  void getAuth(User user) {
    this.user = user;
    notifyListeners();
  }
}