import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qr_flutter/connections/urls.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';

class CirujiaDAO {
  static const String servicio_listar = "/cirujias";
  static const String servicio_crear = "/insertarCirujia";
  static const String servicio_cirujias_card = "/cirujiasTarjetas";

  static List<Cirujias> recibir = [];

  static const String URL = Conn.URL;

  static const headers = {'Content-Type': 'application/json'};

  static Future crearCirujia(json) async {
    print(json);
    http.Response response = await http.post(Uri.parse(URL + servicio_crear),
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print(response.statusCode);
    print(response.body);

    return response;
  }

  Future listarCirujias() async {
    final response = await http.get(Uri.parse(URL + servicio_listar),
        headers: {"Content-Type": "application/json"});
    List<dynamic> cirujia = jsonDecode(response.body);

    return cirujia;
  }

  Future<APIResponse<List<Cirujias>>> obtenerCirujias(
      DateTime lunes, DateTime viernes) async {
    int horaFin;
    int horaTope = 18;
    return await http.get(Uri.parse(URL + servicio_listar + '/$lunes,$viernes'),
        headers: {"Content-Type": "application/json"}).then((data) {
      //log('La respuesta obtenida es -----------: ' + data.body);
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final cirujiaL = <Cirujias>[];
        for (var item in jsonData) {
          log(item.toString());
          cirujiaL.add(Cirujias.fromJson(item));
        }
        //print(data.body);

        recibir = cirujiaL;

        return APIResponse<List<Cirujias>>(data: cirujiaL);
      }
      return APIResponse<List<Cirujias>>(error: true, mensajeError: "Error");
    }).catchError(
        (_) => APIResponse<List<Cirujias>>(error: true, mensajeError: "Error"));
  }

  Future<List<Cirujias>> getCirujiasTarjetas(
      String nombres, String apellidos, String dni) async {
    print(apellidos + " " + " CRDENCIALES");
    final response = await http.post(
        Uri.parse(URL + servicio_cirujias_card + '/$nombres,$apellidos,$dni'));
    if (response.statusCode == 200) {
      print(response.body);
      return _listaNoticias(response.body).toList();
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      return null;
    } else {
      throw Exception("Error del servidor!!");
    }
  }

  static List<Cirujias> _listaNoticias(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cirujias>((json) => Cirujias.fromJson(json)).toList();
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);

      print("----------");
      print("----------");
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
}
