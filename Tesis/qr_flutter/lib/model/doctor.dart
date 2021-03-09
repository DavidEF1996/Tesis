// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.idDoctor,
    this.especialidad,
    this.user,
    this.password,
  });

  String cedula;
  String nombres;
  String apellidos;
  DateTime fechaNacimiento;
  String idDoctor;
  String especialidad;
  String user;
  String password;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        cedula: json["cedula"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        idDoctor: json["idDoctor"],
        especialidad: json["especialidad"],
        user: json["user"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "idDoctor": idDoctor,
        "especialidad": especialidad,
        "user": user,
        "password": password,
      };
}
