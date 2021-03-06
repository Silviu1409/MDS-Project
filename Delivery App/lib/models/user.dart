import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User user) => json.encode(user.toJson);

class User {
  String email;
  String password;
  String username;
  String phoneno;
  String role;
  String image;
  DocumentReference? ref;

  User({
    required this.email,
    required this.password,
    required this.username,
    required this.phoneno,
    required this.role,
    required this.image,
  });

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    final newUser = User.fromJson(snapshot.data() as Map<String, dynamic>);
    newUser.ref = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        username: json["username"],
        phoneno: json["phoneno"],
        role: json["role"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "username": username,
        "phoneno": phoneno,
        "role": role,
        "image": image,
      };
}
