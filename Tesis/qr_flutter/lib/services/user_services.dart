import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static var usuariologueado = "";
  static const API =
      "http://192.168.100.6:8080/operatingRoomRs/ws/operatingRoomServices";
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
      //Map<String, dynamic> user = jsonDecode(decodedata);

      usuariologueado = decodedata['nombres'];
      print(usuariologueado);

      return decodedata;
    } else {
      return null;
    }
  }
}
