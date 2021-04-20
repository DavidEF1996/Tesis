import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static var nombreUsuariologueado = "";
  static var apellidoUsuarioLogueado = "";
  static var usuariologueado = "";
  static const API =
      "http://192.168.18.4:8080/operatingRoomRs/ws/operatingRoomServices";
  // "http://192.168.10.118:8080/operatingRoomRs/ws/operatingRoomServices";

  static const headers = {'Content-Type': 'application/json'};

  Future loginUsuario(String correo, String contrasena) async {
    //print(correo + ' ' + contrasena);
    final body = {"user": correo, "password": contrasena};
    var body2 = jsonEncode(body);
    final respuesta = await http.post(API + "/login",
        headers: headers, body: body2, encoding: Encoding.getByName('utf-8'));

    if (respuesta.statusCode == 200) {
      final decodedata = json.decode(respuesta.body);
      print(respuesta.body);
      print(decodedata);
      print(decodedata['nombres'] + "el nombre");
      //Map<String, dynamic> user = jsonDecodeS(decodedata);

      nombreUsuariologueado = decodedata['nombres'];
      apellidoUsuarioLogueado = decodedata['apellidos'];
      print(nombreUsuariologueado);
      print(apellidoUsuarioLogueado);
      usuariologueado = nombreUsuariologueado.split(" ")[0] +
          " " +
          apellidoUsuarioLogueado.split(" ")[0];
      return decodedata;
    } else {
      return null;
    }
  }
}
