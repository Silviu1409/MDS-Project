import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

Produs userFromJson(String str) => Produs.fromJson(json.decode(str));

String userToJson(Produs user) => json.encode(user.toJson);

class Produs {
  String nume;
  String? descriere;
  Float pret;
  DocumentReference restaurant;
  String? ref_id;

  Produs({
    required this.nume,
    this.descriere,
    required this.pret,
    required this.restaurant,
  });

  factory Produs.fromJson(Map<String, dynamic> json) => Produs(
      nume: json["nume"],
      descriere: json["descriere"],
      pret: json["pret"],
      restaurant: json["restaurant"]);

  Map<String, dynamic> toJson() => {
        "nume": nume,
        "descriere": descriere,
        "pret": pret,
        "restaurant": restaurant,
      };
}
