import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

ShoppingCart userFromJson(String str) =>
    ShoppingCart.fromJson(json.decode(str));

String userToJson(ShoppingCart shoppingcart) =>
    json.encode(shoppingcart.toJson);

class ShoppingCart {
  bool finished;
  String? datetime;
  DocumentReference? user;
  DocumentReference? ref;

  ShoppingCart({
    required this.user,
    required this.finished,
    this.datetime,
  });

  factory ShoppingCart.fromSnapshot(DocumentSnapshot snapshot) {
    final newShoppingCart =
        ShoppingCart.fromJson(snapshot.data() as Map<String, dynamic>);
    newShoppingCart.ref = snapshot.reference;
    return newShoppingCart;
  }

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
