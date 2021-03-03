import 'dart:convert';
import 'package:qr_flutter/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';

class UserService {
  static const API =
      "http://192.168.18.4:8080/operatingRoomRs/ws/operatingRoomServices";
  static const headers = {'Content-Type': 'application/json'};

  Future<bool> loginUsuario(String correo, String contrasena) async {
    //print(correo + ' ' + contrasena);
    final body = {"user": correo, "password": contrasena};
    var body2 = jsonEncode(body);
    dynamic respuesta =
        await http.post(API + "/login", headers: headers, body: body2);
    final decodedata = json.decode(respuesta.body);

    if (decodedata) {
      print(decodedata.toString());
      return true;
    } else {
      return false;
    }
  }
}
