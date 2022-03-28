import 'dart:convert';
import 'dart:ffi';

Restaurant userFromJson(String str) => Restaurant.fromJson(json.decode(str));

String userToJson(Restaurant user) => json.encode(user.toJson);

class Restaurant {
  Int64 id_restaurant;
  String nume;
  String adresa;

  Restaurant({
    required this.id_restaurant,
    required this.nume,
    required this.adresa,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id_restaurant: json["id"],
        nume: json["nume"],
        adresa: json['adresa'],
      );

  Map<String, dynamic> toJson() => {
        "id": id_restaurant,
        "nume": nume,
        "adresa": adresa,
      };
}
