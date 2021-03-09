import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/doctor.dart';

class DoctorDao {
  static const String IP = '192.168.100.6';
  static const int PORT = 8080;
  static const String servicio_crear = "/crear";
  static const String servicio_login = "/login";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};
  static Doctor d = Doctor();

  static Future crearDoctor(json) async {
    print("dao");
    print(json.toString());
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print("pase el metodo");
    print(response.body);
    Map<String, dynamic> user = jsonDecode(response.body);
    print('Howdy, ${user['user']}!');
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

  /*static Future cargarDatosLogin(
      BuildContext context, var password, TextEditingController user) {
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    password = response.body.toString();
    Map<String, dynamic> user = jsonDecode(response.body);

    print('Howdy, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');

    return null;
  }*/

  static Future login(json) async {
    http.Response response = await http.post(URL + servicio_login,
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));
    print("Este es el usuario y contra");
    print(response);
    return response;
  }
}
