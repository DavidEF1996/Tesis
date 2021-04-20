import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/doctor.dart';
import 'package:qr_flutter/model/doctor_consultas.dart';

class DoctorDao {
  static const String IP = '192.168.18.4'; //'192.168.18.4';'192.168.10.118'2

  static const int PORT = 8080;
  static const String servicio_crear = "/crear";
  static const String servicio_login = "/login";
  static const String servicio_change = "/changePass";

  static const String servicio_listarNombres = "/nombresDoctores";

  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';
  //'http://$IP:$PORT/TesisOP/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};
  static Doctor d = Doctor();

  static Future crearDoctor(json) async {
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));

    print(response.body);
    Map<String, dynamic> user = jsonDecode(response.body);
    d.user = user['user'];
    d.password = user['password'];
    return response;
  }

  TextEditingController cargar(
      TextEditingController user, TextEditingController password) {
    user.text = "";
    print("LLegue al cargar" + d.user);

    return user;
  }

  static Future login(json) async {
    http.Response response = await http.post(URL + servicio_login,
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));

    return response;
  }

  static Future<bool> changePass(json) async {
    http.Response response = await http.post(URL + servicio_change,
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));
    //print(response.body);
    if (response.body.contains('true')) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<DoctorLista>> listarDoctores(String nombres) async {
    final response = await http.get(URL + servicio_listarNombres + '/$nombres');
    if (response.statusCode == 200) {
      print(response.body);
      return _listDoctrores(response.body).toList();
    } else if (response.statusCode == 404) {
      print(response.statusCode);
      return null;
    } else {
      throw Exception("Error del servidor!!");
    }
  }
  /*return http.get(URL + servicio_listarNombres + "/$nombres",
        headers: {"Content-Type": "application/json"}).then((data) {
      log('La respuesta obtenida es -----------: ' + data.body);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final cirujiaL = <DoctorLista>[];
        for (var item in jsonData) {
          cirujiaL.add(DoctorLista.fromJson(item));
        }
        return APIResponse<List<DoctorLista>>(data: cirujiaL);
      }
      return APIResponse<List<DoctorLista>>(error: true, mensajeError: "Error");
    }).catchError((_) =>
        APIResponse<List<DoctorLista>>(error: true, mensajeError: "Error"));
  }*/
  /* */

  static List<DoctorLista> _listDoctrores(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<DoctorLista>((json) => DoctorLista.fromJson(json))
        .toList();
  }
  //probando el commit
}
