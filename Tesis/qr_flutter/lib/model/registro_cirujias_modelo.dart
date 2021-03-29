import 'dart:convert';

RegistroCirujias regCirujias(String str) =>
    RegistroCirujias.fromJson(json.decode(str));

String regCirujiasToJson(RegistroCirujias data) => json.encode(data.toJson());

class RegistroCirujias {
  RegistroCirujias({
    this.nombres,
    this.fechaNacimiento,
    this.anos,
    this.meses,
    this.tipoCirujia,
    this.enfermedad,
    this.procedimientoRealizar,
    this.fechaProcedimiento,
    this.horasProcedimiento,
    this.minutosProcedimiento,
    this.necesidadSangre,
    this.examenesSangre,
    this.radiografiasTorax,
    this.ecg,
    this.cuantitativosCovid,
    this.nombreCirujano,
    this.nombreAyudante,
    this.equipoMaterialNecesario,
    this.observaciones,
  });

  String nombres;
  DateTime fechaNacimiento;
  int anos;
  int meses;
  String tipoCirujia;
  String enfermedad;
  String procedimientoRealizar;
  DateTime fechaProcedimiento;
  int horasProcedimiento;
  int minutosProcedimiento;
  String necesidadSangre;
  String examenesSangre;
  String radiografiasTorax;
  String ecg;
  String cuantitativosCovid;
  String nombreCirujano;
  String nombreAyudante;
  String equipoMaterialNecesario;
  String observaciones;

  factory RegistroCirujias.fromJson(Map<String, dynamic> json) =>
      RegistroCirujias(
        nombres: json["nombres"],
        fechaNacimiento: DateTime.parse(json["fechaNacimiento"]),
        anos: json["anos"],
        meses: json["meses"],
        tipoCirujia: json["tipoCirujia"],
        enfermedad: json["enfermedad"],
        procedimientoRealizar: json["procedimientoRealizara"],
        fechaProcedimiento: DateTime.parse(json["fechaProcedimiento"]),
        horasProcedimiento: json["horasProcedimiento"],
        minutosProcedimiento: json["minutosProcedimiento"],
        necesidadSangre: json["necesidadSangre"],
        examenesSangre: json["examenesSangre"],
        radiografiasTorax: json["radiografiasTorax"],
        ecg: json["ecg"],
        cuantitativosCovid: json["cuantitativosCovid"],
        nombreCirujano: json["nombreCirujano"],
        nombreAyudante: json["nombreAyudante"],
        equipoMaterialNecesario: json["equipoMaterialNecesario"],
        observaciones: json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "nombres": nombres,
        "fechaNacimiento":
            "${fechaNacimiento.year.toString().padLeft(4, '0')}-${fechaNacimiento.month.toString().padLeft(2, '0')}-${fechaNacimiento.day.toString().padLeft(2, '0')}",
        "anos": anos,
        "meses": meses,
        "tipoCirujia": tipoCirujia,
        "enfermedad": enfermedad,
        "procedimientoRealizar": procedimientoRealizar,
        "fechaProcedimiento":
            "${fechaProcedimiento.year.toString().padLeft(4, '0')}-${fechaProcedimiento.month.toString().padLeft(2, '0')}-${fechaProcedimiento.day.toString().padLeft(2, '0')}",
        "horasProcedimiento": horasProcedimiento,
        "minutosProcedimiento": minutosProcedimiento,
        "necesidadSangre": necesidadSangre,
        "examenesSangre": examenesSangre,
        "radiografiasTorax": radiografiasTorax,
        "ecg": ecg,
        "cuantitativosCovid": cuantitativosCovid,
        "nombreCirujano": nombreCirujano,
        "nombreAyudante": nombreAyudante,
        "equipoMaterialNecesario": equipoMaterialNecesario,
        "observaciones": observaciones,
      };
}
