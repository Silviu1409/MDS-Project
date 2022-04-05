import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

OrderItem userFromJson(String str) => OrderItem.fromJson(json.decode(str));

String userToJson(OrderItem orderitem) => json.encode(orderitem.toJson);

class OrderItem {
  DocumentReference produs;
  DocumentReference shoppingcart;
  int cantitate;
  DocumentReference? ref;

  OrderItem({
    required this.produs,
    required this.shoppingcart,
    required this.cantitate,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      produs: json["product"],
      shoppingcart: json["shoppingcart"],
      cantitate: json["quantity"]);

  Map<String, dynamic> toJson() => {
        "product": produs,
        "shopping": shoppingcart,
        "quantity": cantitate,
      };
}
