import 'dart:convert';
import 'dart:ffi';
import 'package:delivery_app/models/produs.dart';


Restaurant userFromJson(String str) => Restaurant.fromJson(json.decode(str));

String userToJson(Restaurant user) => json.encode(user.toJson);

class Restaurant {
  Int64 id_restaurant;
  String nume;
  String adresa;
  List<Produs> produse_restaurant;


  Restaurant({
    required this.id_restaurant,
    required this.nume,
    required this.adresa,
    required this.produse_restaurant,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id_restaurant: json["id"],
        nume: json["nume"],
        adresa: json['adresa'],
        produse_restaurant: json["produse"],
      );

  Map<String, dynamic> toJson() => {
        "id": id_restaurant,
        "nume": nume,
        "adresa": adresa,
        "produse": produse_restaurant,
      };
}
