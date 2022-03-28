import 'dart:convert';
import 'dart:ffi';

OrderItem userFromJson(String str) => OrderItem.fromJson(json.decode(str));

String userToJson(OrderItem user) => json.encode(user.toJson);

class OrderItem {
  Int64 id_order;
  Int64 id_produs;
  Int64 id_shopping;
  Int64 cantitate;

  OrderItem({
    required this.id_order,
    required this.id_produs,
    required this.id_shopping,
    required this.cantitate,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
      id_order: json["id"],
      id_produs: json["id_produs"],
      id_shopping: json["id_shopping"],
      cantitate: json["cantitate"]);

  Map<String, dynamic> toJson() => {
        "id": id_order,
        "id_produs": id_shopping,
        "id_shopping": id_shopping,
        "cantitate": cantitate,
      };
}
