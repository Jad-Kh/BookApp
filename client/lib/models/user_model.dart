class User {
  String username;
  String email;
  String password;
  List<String> lists;
  List<String> friends;
  List<String> requests;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.lists,
    required this.friends,
    required this.requests
  });
} 