import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Restaurant userFromJson(String str) => Restaurant.fromJson(json.decode(str));

String userToJson(Restaurant restaurant) => json.encode(restaurant.toJson);

class Restaurant {
  String nume;
  String adresa;
  String thumbnail;
  DocumentReference? ref;

  Restaurant({
    required this.nume,
    required this.adresa,
    required this.thumbnail,
  });

  factory Restaurant.fromSnapshot(DocumentSnapshot snapshot) {
    final newRestaurant =
        Restaurant.fromJson(snapshot.data() as Map<String, dynamic>);
    newRestaurant.ref = snapshot.reference;
    return newRestaurant;
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        nume: json["name"],
        adresa: json["address"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "name": nume,
        "address": adresa,
        "thumbnail": thumbnail,
      };
}
