import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/connections/urls.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/diagnostico.dart';

class DiagnosticoDao {
  static const String servicio_filtro = "/listaFiltro";
  static const String servicio_listar_todo = "/listaDgn";
  static const String URL = Conn.URL;

  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse<List<Diagnostico>>> getDiagnosticos(codigo) async {
    return http.get(Uri.parse(URL + servicio_filtro + '/$codigo'),
        headers: {"Content-Type": "application/json"}).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final diagnosticoL = <Diagnostico>[];
        for (var item in jsonData) {
          print(item);
          diagnosticoL.add(Diagnostico.fromJson(item));
        }
        return APIResponse<List<Diagnostico>>(data: diagnosticoL);
      }
      return APIResponse<List<Diagnostico>>(error: true, mensajeError: "Error");
    }).catchError((_) =>
        APIResponse<List<Diagnostico>>(error: true, mensajeError: "Error"));
  }

  static Future<List<Diagnostico>> listarDiagnosticos() async {
    final response = await http.get(Uri.parse(URL + servicio_listar_todo));
    if (response.statusCode == 200) {
      return _listDiagnostico(response.body);
    } else {
      throw Exception("Error de fecth");
    }
  }

  static List<Diagnostico> _listDiagnostico(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Diagnostico>((json) => Diagnostico.fromJson(json))
        .toList();
  }
}
