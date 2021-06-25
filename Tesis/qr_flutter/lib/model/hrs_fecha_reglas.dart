// To parse this JSON data, do
//
//     final hrsFechaReglas = hrsFechaReglasFromJson(jsonString);

import 'dart:convert';

HrsFechaReglas hrsFechaReglasFromJson(String str) =>
    HrsFechaReglas.fromJson(json.decode(str));

String hrsFechaReglasToJson(HrsFechaReglas data) => json.encode(data.toJson());

class HrsFechaReglas {
  HrsFechaReglas({
    this.hora,
    this.fecha,
  });

  String hora;
  DateTime fecha;

  factory HrsFechaReglas.fromJson(Map<String, dynamic> json) => HrsFechaReglas(
        hora: json["hora"],
        fecha: DateTime.parse(json["fecha"]),
      );

  Map<String, dynamic> toJson() => {
        "hora": hora,
        "fecha":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      };
}
