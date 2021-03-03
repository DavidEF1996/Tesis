// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

Doctor doctorFromJson(String str) => Doctor.fromJson(json.decode(str));

String doctorToJson(Doctor data) => json.encode(data.toJson());

class Doctor {
  Doctor({
    this.cedula,
    this.primerNombre,
    this.segundoNombre,
    this.apellidoPaterno,
    this.apellidoMaterno,
    this.fechaNacimiento,
    this.idDoctor,
    this.especialidad,
    this.user,
    this.password,
  });

  String cedula;
  String primerNombre;
  String segundoNombre;
  String apellidoPaterno;
  String apellidoMaterno;
  DateTime fechaNacimiento;
  String idDoctor;
  String especialidad;
  String user;
  String password;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        cedula: json["cedula"],
        primerNombre: json["primerNombre"],
        segundoNombre: json["segundoNombre"],
        apellidoPaterno: json["apellidoPaterno"],
        apellidoMaterno: json["apellidoMaterno"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        idDoctor: json["idDoctor"],
        especialidad: json["especialidad"],
        user: json["user"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "primerNombre": primerNombre,
        "segundoNombre": segundoNombre,
        "apellidoPaterno": apellidoPaterno,
        "apellidoMaterno": apellidoMaterno,
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "idDoctor": idDoctor,
        "especialidad": especialidad,
        "user": user,
        "password": password,
      };
}
