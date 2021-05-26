// To parse this JSON data, do
//
//     final doctor = doctorFromJson(jsonString);

import 'dart:convert';

DatosCirujia doctorFromJson(String str) =>
    DatosCirujia.fromJson(json.decode(str));

String doctorToJson(DatosCirujia data) => json.encode(data.toJson());

class DatosCirujia {
  DatosCirujia(
      {this.indice,
      this.numeroQuirofano,
      this.nombreCirujano,
      this.fechaCirujia,
      this.horaInicio,
      this.estado});

  int indice;
  int numeroQuirofano;
  String nombreCirujano;
  DateTime fechaCirujia;
  String horaInicio;
  String estado;

  factory DatosCirujia.fromJson(Map<String, dynamic> json) => DatosCirujia(
      indice: json["indice"],
      numeroQuirofano: json["numeroQuirofano"],
      nombreCirujano: json["nombreCirujano"],
      fechaCirujia: DateTime.parse(json["fechaCirujia"]),
      horaInicio: json["horaInicio"],
      estado: json["estado"]);

  Map<String, dynamic> toJson() => {
        "indice": indice,
        "numeroQuirofano": numeroQuirofano,
        "nombreCirujano": nombreCirujano,
        "fechaCirujia":
            "${fechaCirujia.year.toString().padLeft(4, '0')}-${fechaCirujia.month.toString().padLeft(2, '0')}-${fechaCirujia.day.toString().padLeft(2, '0')}",
        "horaInicio": horaInicio,
        "estado": estado
      };
}
