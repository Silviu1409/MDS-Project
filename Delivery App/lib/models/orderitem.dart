import 'dart:convert';
import 'dart:ffi';

import 'package:delivery_app/models/produs.dart';
import 'package:delivery_app/models/shoppingcart.dart';

OrderItem userFromJson(String str) => OrderItem.fromJson(json.decode(str));

String userToJson(OrderItem user) => json.encode(user.toJson);


class OrderItem {
  Int64 id_order;
  Produs produs;
  ShoppingCart shoppingCart;
  Int64 cantitate;
  
  OrderItem({
    required this.id_order,
    required this.produs,
    required this.shoppingCart,
    required this.cantitate,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id_order: json["id"],
        produs: json["id_produs"],
        shoppingCart: json["id_shoppingCart"],
        cantitate: json["cantitate"]
      );

  Map<String, dynamic> toJson() => {
        "id": id_order,
        "id_produs": produs,
        "id_shoppingCart": shoppingCart,
        "cantitate": cantitate,
      };
}
