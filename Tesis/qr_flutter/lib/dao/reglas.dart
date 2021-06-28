import 'dart:convert';

import 'package:qr_flutter/connections/urls.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/preferences/preferences.dart';

class ReglasDao {
  static const String URL = Conn.URL_PYTHON;
  static const String servicio_pruebas = "/regla_privada";
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
}
