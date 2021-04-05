import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/diagnostico.dart';
import 'package:qr_flutter/model/doctor.dart';

class DiagnosticoDao {
  static const String IP = '192.168.10.118'; //'192.168.18.4';'192.168.10.118'
  static const int PORT = 8080;
  static const String servicio_filtro = "/listaFiltro";
  static const String servicio_listar_todo = "/listaDgn";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};

  static Future<List<Diagnostico>> getDiagnosticos(String codigo) async {
    http.Response response = await http.get(URL + servicio_filtro + '/$codigo');
    print(response.body);
    List<Diagnostico> lista = jsonDecode(response.body);
    return lista;
  }

  static getAll() async {
    http.Response response = await http.get(URL + servicio_listar_todo);
    print(response.body.length);
    print("tamanio");
    List<Diagnostico> lista = jsonDecode(response.body);
    print(lista.length);
    List<String> stringList =
        (jsonDecode(response.body) as List<String>).cast<String>();
    return stringList;
  }
}

const String IP = '192.168.10.118'; //'192.168.18.4';'192.168.10.118'
const int PORT = 8080;
const String servicio_filtro = "/listaFiltro";
const String servicio_listar_todo = "/listaDgn";
const String URL = 'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';
List<Diagnostico> parseDiagnostico(String responseBody) {
  var l = json.decode(responseBody) as List<dynamic>;
  var posts = l.map((model) => Diagnostico.fromJson(model)).toList();
  return posts;
}

Future<List<Diagnostico>> fecthDiagnostico() async {
  final response = await http.get(URL + servicio_listar_todo);
  if (response.statusCode == 200) {
    return compute(parseDiagnostico, response.body);
  } else if (response.statusCode == 404) {
    throw Exception("Error al encontrar");
  } else {
    throw Exception("Error de fecth");
  }
}
