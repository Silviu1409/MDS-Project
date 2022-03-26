import 'dart:convert';
import 'dart:ffi';

Produs userFromJson(String str) => Produs.fromJson(json.decode(str));

String userToJson(Produs user) => json.encode(user.toJson);

class Produs {
  Int64 id;
  String nume;
  String? descriere;
  Float pret;


  Produs({
    required this.id,
    required this.nume,
    this.descriere,
    required this.pret,
  });

  factory Produs.fromJson(Map<String, dynamic> json) => Produs(
        id: json["id"],
        nume: json["nume"],
        descriere: json["descriere"],
        pret: json["pret"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nume": nume,
        "descriere": descriere,
        "pret": pret,
      };
}
