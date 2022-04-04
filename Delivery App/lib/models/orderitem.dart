import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

OrderItem userFromJson(String str) => OrderItem.fromJson(json.decode(str));

String userToJson(OrderItem user) => json.encode(user.toJson);

class OrderItem {
  DocumentReference produs;
  DocumentReference shoppingcart;
  int cantitate;
  String? ref_id;

  OrderItem({
    required this.produs,
    required this.shoppingcart,
    required this.cantitate,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      produs: json["produs"],
      shoppingcart: json["shoppingcart"],
      cantitate: json["cantitate"]);

  Map<String, dynamic> toJson() => {
        "produs": produs,
        "shopping": shoppingcart,
        "cantitate": cantitate,
      };
}
