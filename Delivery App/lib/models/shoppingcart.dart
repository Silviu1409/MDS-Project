import 'dart:convert';
import 'dart:ffi';
import 'package:delivery_app/models/user.dart';

ShoppingCart userFromJson(String str) =>
    ShoppingCart.fromJson(json.decode(str));

String userToJson(ShoppingCart user) => json.encode(user.toJson);

class ShoppingCart {
  Int64 id_shopping;
  User user;

  ShoppingCart({
    required this.id_shopping,
    required this.user,
  });

  factory ShoppingCart.fromJson(Map<String, dynamic> json) => ShoppingCart(
        id_shopping: json["id"],
        user: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id_shopping,
        "email": user,
      };
}
