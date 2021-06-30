import 'dart:convert';

import 'package:qr_flutter/connections/urls.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/preferences/preferences.dart';

class ReglasDao {
  static const String URL = Conn.URL_PYTHON;
  static const String servicio_pruebas = "/regla_privada";
  static const String servicio_tipo_cirujia = '/regla_tipo_cirujia';
  static const headers = {'Content-Type': 'application/json'};
  bool autorizacion = false;
  final _preferences = new Preferences();

  Future<APIResponse> validarHoras(json) async {
    http.Response response = await http.post(Uri.parse(URL + servicio_pruebas),
        body: json, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> datos = jsonDecode(response.body);
      _preferences.autorizacion = datos["4"]["autorizar_red"];
      print("en el srvc es:");
      print(datos["4"]["autorizar_red"]);
    } else {
      print(response.statusCode);
    }
  }

  Future<APIResponse> reglaTipoCirujia(String tipo) async {
    print("llega al swrvio");
    http.Response response = await http.post(
        Uri.parse(URL + servicio_tipo_cirujia + '/$tipo'),
        headers: headers);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> datos = jsonDecode(response.body);
      _preferences.hora_inicio = datos['2']['hora_inicio'];
      _preferences.hora_fin = datos['3']['hora_fin'];
      _preferences.numero_dias = datos['4']['numero_dias'];
      print(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
