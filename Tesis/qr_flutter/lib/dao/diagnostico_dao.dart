import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/diagnostico.dart';

class DiagnosticoDao {
  static const String IP = '192.168.18.4'; //'192.168.18.4';'192.168.10.41'
  static const int PORT = 8080;
  static const String servicio_filtro = "/listaFiltro";
  static const String servicio_listar_todo = "/listaDgn";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};

  /*static Future<List<Diagnostico>> getDiagnosticos(String codigo) async {
    final response = await http.get(URL + servicio_filtro + '/$codigo');
    if (response.statusCode == 200) {
      return _listDiagnostico(response.body).toList();
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      return null;
    } else {
      throw Exception("Error del servidor!!");
    }
    /*print(response.body);
    List<Diagnostico> lista = jsonDecode(response.body);
    return lista;*/
  }*/
  Future<APIResponse<List<Diagnostico>>> getDiagnosticos(codigo) async {
    return http.get(URL + servicio_filtro + '/$codigo',
        headers: {"Content-Type": "application/json"}).then((data) {
      //log('La respuesta obtenida es -----------: ' + data.body);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final doctorL = <Diagnostico>[];
        for (var item in jsonData) {
          doctorL.add(Diagnostico.fromJson(item));
        }
        return APIResponse<List<Diagnostico>>(data: doctorL);
      }
      return APIResponse<List<Diagnostico>>(error: true, mensajeError: "Error");
    }).catchError((_) =>
        APIResponse<List<Diagnostico>>(error: true, mensajeError: "Error"));
  }

  static Future<List<Diagnostico>> listarDiagnosticos() async {
    final response = await http.get(URL + servicio_listar_todo);
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
