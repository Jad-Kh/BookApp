class User {
  String username;
  String email;
  String password;
  int points;
  List<String> lists;
  List<String> friends;
  List<String> requests;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.points,
    required this.lists,
    required this.friends,
    required this.requests
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var listsObj = json['lists'];
    var friendsObj = json['friends'];
    var requestsObj = json['requests'];

    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      points: json['points'],
      lists: new List<String>.from(listsObj),
      friends: new List<String>.from(friendsObj),
      requests: new List<String>.from(requestsObj),
    );
  }
} 