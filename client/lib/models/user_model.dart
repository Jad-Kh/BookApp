class User {
  String username;
  String email;
  String password;
  int recommendations;
  int flag;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.recommendations,
    required this.flag
  });

  factory User.fromJson(Map<String, dynamic> json) {

    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      recommendations: json['recommendations'],
      flag: json['flag'],
    );
  }
} 