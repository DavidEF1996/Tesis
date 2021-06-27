import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/connections/urls.dart';
import 'package:qr_flutter/utils/utils.dart';

class UserService {
  static var nombreUsuariologueado = "";
  static var apellidoUsuarioLogueado = "";
  static var usuariologueado = "";
  static var nombreCompletoUsuarioLogueado = "";
  static var nombres = "";
  static var apellidos = "";
  static const URL = Conn.URL;

  static const headers = {"Content-type": " application/json"};

  Future loginUsuario(BuildContext context, correo, String contrasena) async {
    //print(correo + ' ' + contrasena);
    final body = {"user": correo, "password": contrasena};
    var body2 = jsonEncode(body);
    final respuesta = await http.post(Uri.parse(URL + "/login"),
        headers: headers, body: body2, encoding: Encoding.getByName('utf-8'));

    if (respuesta.statusCode == 200) {
      final decodedata = json.decode(respuesta.body);
      if (decodedata['acceso']) {
        nombres = decodedata['nombres'];
        apellidos = decodedata['apellidos'];
        nombreUsuariologueado = decodedata['nombres'];
        apellidoUsuarioLogueado = decodedata['apellidos'];

        usuariologueado = nombreUsuariologueado.split(" ")[0] +
            " " +
            apellidoUsuarioLogueado.split(" ")[0];

        nombreCompletoUsuarioLogueado =
            nombreUsuariologueado + " " + apellidoUsuarioLogueado;
        return decodedata;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
