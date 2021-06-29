// To parse this JSON data, do
//
//     final cirujias = cirujiasFromJson(jsonString);

import 'dart:convert';

List<Cirujias> cirujiasFromJson(String str) =>
    List<Cirujias>.from(json.decode(str).map((x) => Cirujias.fromJson(x)));

String cirujiasToJson(List<Cirujias> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cirujias {
  Cirujias({
    this.idCirujia,
    this.paciente,
    this.edadPaciente,
    this.diagnostico,
    this.horaFin,
    this.necesidadSangre,
    this.examenSangre,
    this.examenTorax,
    this.crjEcj,
    this.covid,
    this.materiales,
    this.observaciones,
    this.tipoCirujia,
    this.estadoCirujia,
    this.procedimiento,
    this.doctores,
    this.quirofano,
    this.fechaCirujia,
    this.horaInicio,
    this.duracion,
    this.anios,
    this.fechaNacimiento,
    this.meses,
    this.redCirujia,
  });

  int idCirujia;
  String paciente;
  int edadPaciente;
  DiagnosticoCp diagnostico;
  String horaFin;
  String necesidadSangre;
  String examenSangre;
  bool examenTorax;
  bool crjEcj;
  bool covid;
  String materiales;
  String observaciones;
  String tipoCirujia;
  String estadoCirujia;
  String procedimiento;
  List<Doctore> doctores;
  int quirofano;
  int fechaCirujia;
  String horaInicio;
  String duracion;
  int anios;
  int meses;
  int fechaNacimiento;
  String redCirujia;

  factory Cirujias.fromJson(Map<String, dynamic> json) => Cirujias(
        idCirujia: json["idCirujia"],
        paciente: json["paciente"],
        edadPaciente: json["edadPaciente"],
        diagnostico: DiagnosticoCp.fromJson(json["diagnostico"]),
        horaFin: json["horaFin"],
        necesidadSangre: json["necesidadSangre"],
        examenSangre: json["examenSangre"],
        examenTorax: json["examenTorax"],
        crjEcj: json["crjECJ"],
        covid: json["covid"],
        materiales: json["materiales"],
        observaciones: json["observaciones"],
        tipoCirujia: json["tipoCirujia"],
        estadoCirujia: json["estadoCirujia"],
        procedimiento: json["procedimiento"],
        doctores: List<Doctore>.from(
            json["doctores"].map((x) => Doctore.fromJson(x))),
        quirofano: json["quirofano"],
        fechaCirujia: json["fechaCirujia"],
        horaInicio: json["horaInicio"],
        duracion: json["duracion"],
        anios: json['anios'],
        meses: json['meses'],
        fechaNacimiento: json['fechaNacimiento'],
        redCirujia: json['redCirujia'],
      );

  Map<String, dynamic> toJson() => {
        "idCirujia": idCirujia,
        "paciente": paciente,
        "edadPaciente": edadPaciente,
        "diagnostico": diagnostico.toJson(),
        "horaFin": horaFin,
        "necesidadSangre": necesidadSangre,
        "examenSangre": examenSangre,
        "examenTorax": examenTorax,
        "crjECJ": crjEcj,
        "covid": covid,
        "materiales": materiales,
        "observaciones": observaciones,
        "tipoCirujia": tipoCirujia,
        "estadoCirujia": estadoCirujia,
        "procedimiento": procedimiento,
        "doctores": List<dynamic>.from(doctores.map((x) => x.toJson())),
        "quirofano": quirofano,
        "fechaCirujia": fechaCirujia,
        "horaInicio": horaInicio,
        "duracion": duracion,
        "anios": anios,
        "meses": meses,
        "fechaNacimiento": fechaNacimiento,
        "redCirujia": redCirujia,
      };
}

class DiagnosticoCp {
  DiagnosticoCp({
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
  dynamic nombreTresCaracteres;
  String codigoCuatro;
  String nombreCuatroCaracteres;

  factory DiagnosticoCp.fromJson(Map<String, dynamic> json) => DiagnosticoCp(
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

class Doctore {
  Doctore({
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

  dynamic cedula;
  String nombres;
  String apellidos;
  dynamic fechaNacimiento;
  String idDoctor;
  String especialidad;
  dynamic user;
  dynamic password;
  int bandera;
  bool acceso;

  factory Doctore.fromJson(Map<String, dynamic> json) => Doctore(
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
