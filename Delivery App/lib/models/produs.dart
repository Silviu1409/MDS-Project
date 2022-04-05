import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

Produs userFromJson(String str) => Produs.fromJson(json.decode(str));

String userToJson(Produs produs) => json.encode(produs.toJson);

class Produs {
  String nume;
  String? descriere;
  num pret;
  DocumentReference restaurant;
  DocumentReference? ref;

  Produs({
    required this.nume,
    this.descriere,
    required this.pret,
    required this.restaurant,
  });

  factory Produs.fromSnapshot(DocumentSnapshot snapshot) {
    final newProdus = Produs.fromJson(snapshot.data() as Map<String, dynamic>);
    newProdus.ref = snapshot.reference;
    return newProdus;
  }

  factory Produs.fromJson(Map<String, dynamic> json) => Produs(
      nume: json["name"],
      descriere: json["description"],
      pret: json["price"],
      restaurant: json["restaurant"]);

  Map<String, dynamic> toJson() => {
        "name": nume,
        "description": descriere,
        "price": pret,
        "restaurant": restaurant,
      };
}
