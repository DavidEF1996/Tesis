// To parse this JSON data, do
//
//     final echosFromTable = echosFromTableFromJson(jsonString);

import 'dart:convert';

Map<String, EchosFromTable> echosFromTableFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, EchosFromTable>(k, EchosFromTable.fromJson(v)));

String echosFromTableToJson(Map<String, EchosFromTable> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class EchosFromTable {
    EchosFromTable({
        this.factid,
        this.hora,
        this.day,
        this.numeroDias,
        this.autorizarRed,
    });

    int factid;
    int hora;
    String day;
    int numeroDias;
    bool autorizarRed;

    factory EchosFromTable.fromJson(Map<String, dynamic> json) => EchosFromTable(
        factid: json["__factid__"],
        hora: json["hora"] == null ? null : json["hora"],
        day: json["day"] == null ? null : json["day"],
        numeroDias: json["numero_dias"] == null ? null : json["numero_dias"],
        autorizarRed: json["autorizar_red"] == null ? null : json["autorizar_red"],
    );

    Map<String, dynamic> toJson() => {
        "__factid__": factid,
        "hora": hora == null ? null : hora,
        "day": day == null ? null : day,
        "numero_dias": numeroDias == null ? null : numeroDias,
        "autorizar_red": autorizarRed == null ? null : autorizarRed,
    };
}
