import 'dart:convert';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_app/models/user.dart';

ShoppingCart userFromJson(String str) =>
    ShoppingCart.fromJson(json.decode(str));

String userToJson(ShoppingCart user) => json.encode(user.toJson);

class ShoppingCart {
  String finished;
  String? datetime;
  DocumentReference user;
  String? ref_id;

  ShoppingCart({
    required this.user,
    required this.finished,
    this.datetime,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        user: json["user"],
        finished: json["finished"],
        datetime: json["datetime"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "finished": finished,
        "datetime": datetime,
      };
}
