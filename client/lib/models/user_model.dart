class User {
  String username;
  String email;
  String password;
  List<String> recommendations;
  int flag;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.recommendations,
    required this.flag
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var recommendationObj = json['recommendations'];

    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      recommendations: new List<String>.from(recommendationObj),
      flag: json['flag'],
    );
  }
} 