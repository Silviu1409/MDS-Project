import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User user) => json.encode(user.toJson);

class User {
  String email;
  String password;
  String username;
  String phoneno;
  String role;

  User({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneno,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        username: json["username"],
        phoneno: json["phoneno"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
        "phoneno": phoneno,
        "role": role,
      };
}
