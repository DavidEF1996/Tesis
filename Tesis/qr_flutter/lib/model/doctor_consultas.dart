// To parse this JSON data, do
//
//     final doctorLista = doctorListaFromJson(jsonString);

import 'dart:convert';

DoctorLista doctorListaFromJson(String str) =>
    DoctorLista.fromJson(json.decode(str));

String doctorListaToJson(DoctorLista data) => json.encode(data.toJson());

class DoctorLista {
  DoctorLista({
    this.dniDoctor,
    this.persona,
    this.especialidad,
    this.user,
    this.password,
    this.bandera,
  });

  String dniDoctor;
  Persona persona;
  String especialidad;
  String user;
  String password;
  int bandera;

  factory DoctorLista.fromJson(Map<String, dynamic> json) => DoctorLista(
        dniDoctor: json["dniDoctor"],
        persona: Persona.fromJson(json["persona"]),
        especialidad: json["especialidad"],
        user: json["user"],
        password: json["password"],
        bandera: json["bandera"],
      );

  Map<String, dynamic> toJson() => {
        "dniDoctor": dniDoctor,
        "persona": persona.toJson(),
        "especialidad": especialidad,
        "user": user,
        "password": password,
        "bandera": bandera,
      };
}

class Persona {
  Persona({
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
  });

  String cedula;
  String nombres;
  String apellidos;
  int fechaNacimiento;

  factory Persona.fromJson(Map<String, dynamic> json) => Persona(
        cedula: json["cedula"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        fechaNacimiento: json["fechaNacimiento"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "fechaNacimiento": fechaNacimiento,
      };
}
