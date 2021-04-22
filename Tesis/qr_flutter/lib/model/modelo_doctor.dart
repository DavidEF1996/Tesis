// To parse this JSON data, do
//
//     final doctorModelo = doctorModeloFromJson(jsonString);

import 'dart:convert';

List<DoctorModelo> doctorModeloFromJson(String str) => List<DoctorModelo>.from(
    json.decode(str).map((x) => DoctorModelo.fromJson(x)));

String doctorModeloToJson(List<DoctorModelo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorModelo {
  DoctorModelo({
    this.cedula,
    this.nombres,
    this.apellidos,
    this.fechaNacimiento,
    this.idDoctor,
    this.especialidad,
    this.user,
    this.password,
    this.bandera,
    this.acceso,
  });

  String cedula;
  String nombres;
  String apellidos;
  int fechaNacimiento;
  String idDoctor;
  String especialidad;
  String user;
  String password;
  int bandera;
  bool acceso;

  factory DoctorModelo.fromJson(Map<String, dynamic> json) => DoctorModelo(
        cedula: json["cedula"],
        nombres: json["nombres"],
        apellidos: json["apellidos"],
        fechaNacimiento: json["fechaNacimiento"],
        idDoctor: json["idDoctor"],
        especialidad: json["especialidad"],
        user: json["user"],
        password: json["password"],
        bandera: json["bandera"],
        acceso: json["acceso"],
      );

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "fechaNacimiento": fechaNacimiento,
        "idDoctor": idDoctor,
        "especialidad": especialidad,
        "user": user,
        "password": password,
        "bandera": bandera,
        "acceso": acceso,
      };
}
