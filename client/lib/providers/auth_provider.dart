import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  User user = User(username: "", email: "", password: "", recommendations: 0, flag: 0);
  AuthProvider();
  void getAuth(User user) {
    this.user = user;
    notifyListeners();
  }
  void updateRecommendations(int recommendations) {
    this.user.recommendations = recommendations;
  }
}