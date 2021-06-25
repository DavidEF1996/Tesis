import 'package:qr_flutter/connections/urls.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';

class ReglasDao {
  static const String URL = Conn.URL_PYTHON;
  static const String servicio_pruebas = "/regla_privada";
  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse> validarHoras(json) {
    print(json);
    return http
        .post(Uri.parse(URL + servicio_pruebas), body: json, headers: headers)
        // ignore: missing_return
        .then((data) {
      print(data.body);
      print('este es el resultado');
    });
  }
}
