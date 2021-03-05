import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const API =
      "http://192.168.18.9:8080/operatingRoomRs/ws/operatingRoomServices";
  static const headers = {'Content-Type': 'application/json'};

  Future loginUsuario(String correo, String contrasena) async {
    //print(correo + ' ' + contrasena);
    final body = {"user": correo, "password": contrasena};
    var body2 = jsonEncode(body);
    final respuesta =
        await http.post(API + "/login", headers: headers, body: body2);

    if (respuesta.statusCode == 200) {
      final decodedata = json.decode(respuesta.body);
      print('entras');
      return decodedata;
    } else {
      return null;
    }
  }
}
