import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/doctor.dart';

class DoctorDao {
  //static const String IP = '192.168.18.125'; //'192.168.18.4';'192.168.10.118'
  static const String IP = '192.168.100.8'; //'192.168.18.4';'192.168.10.118'

  static const int PORT = 8080;
  static const String servicio_crear = "/crear";
  static const String servicio_login = "/login";
  static const String servicio_change = "/changePass";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};
  static Doctor d = Doctor();

  static Future crearDoctor(json) async {
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));

    print(response.body);
    Map<String, dynamic> user = jsonDecode(response.body);
    d.user = user['user'];
    d.password = user['password'];
    print("El usuario que se planea enviar:" + d.user);
    print("la contraseña que se envia: " + d.password);
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
}
