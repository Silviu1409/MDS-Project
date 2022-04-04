import 'dart:convert';
import 'dart:ffi';

Restaurant userFromJson(String str) => Restaurant.fromJson(json.decode(str));

String userToJson(Restaurant user) => json.encode(user.toJson);

class Restaurant {
  String nume;
  String adresa;
  String? ref_id;

  Restaurant({
    required this.nume,
    required this.adresa,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        nume: json["nume"],
        adresa: json['adresa'],
      );

  Map<String, dynamic> toJson() => {
        "nume": nume,
        "adresa": adresa,
      };
}
