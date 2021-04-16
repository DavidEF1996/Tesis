// To parse this JSON data, do
//
//     final diagnostico = diagnosticoFromJson(jsonString);

import 'dart:convert';

import 'package:riverpod/riverpod.dart';

Diagnostico diagnosticoFromJson(String str) =>
    Diagnostico.fromJson(json.decode(str));

String diagnosticoToJson(Diagnostico data) => json.encode(data.toJson());

class Diagnostico {
  Diagnostico({
    this.idDiagnostico,
    this.capitulo,
    this.nombreCapitulo,
    this.codigoTres,
    this.nombreTresCaracteres,
    this.codigoCuatro,
    this.nombreCuatroCaracteres,
  });

  int idDiagnostico;
  String capitulo;
  String nombreCapitulo;
  String codigoTres;
  String nombreTresCaracteres;
  String codigoCuatro;
  String nombreCuatroCaracteres;

  factory Diagnostico.fromJson(Map<String, dynamic> json) => Diagnostico(
        idDiagnostico: json["idDiagnostico"],
        capitulo: json["capitulo"],
        nombreCapitulo: json["nombreCapitulo"],
        codigoTres: json["codigoTres"],
        nombreTresCaracteres: json["nombreTresCaracteres"],
        codigoCuatro: json["codigoCuatro"],
        nombreCuatroCaracteres: json["nombreCuatroCaracteres"],
      );

  Map<String, dynamic> toJson() => {
        "idDiagnostico": idDiagnostico,
        "capitulo": capitulo,
        "nombreCapitulo": nombreCapitulo,
        "codigoTres": codigoTres,
        "nombreTresCaracteres": nombreTresCaracteres,
        "codigoCuatro": codigoCuatro,
        "nombreCuatroCaracteres": nombreCuatroCaracteres,
      };
}

class DiagnosticoList extends StateNotifier<List<Diagnostico>> {
  DiagnosticoList(List<Diagnostico> state) : super(state ?? []);

  void addAll(diagnostico) {
    state.addAll(diagnostico);
  }
}
