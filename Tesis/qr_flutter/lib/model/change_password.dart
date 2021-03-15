// To parse this JSON data, do
//
//     final changepass = changepassFromJson(jsonString);

import 'dart:convert';

Changepass changepassFromJson(String str) =>
    Changepass.fromJson(json.decode(str));

String changepassToJson(Changepass data) => json.encode(data.toJson());

class Changepass {
  Changepass({
    this.idDoctor,
    this.password,
  });

  String idDoctor;
  String password;

  factory Changepass.fromJson(Map<String, dynamic> json) => Changepass(
        idDoctor: json["idDoctor"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "idDoctor": idDoctor,
        "password": password,
      };
}
