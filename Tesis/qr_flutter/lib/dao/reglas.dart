import 'package:qr_flutter/connections/urls.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';

class ReglasDao {
  static const String URL = Conn.URL_PYTHON;
  static const String servicio_pruebas = "/products";
  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse> getProduct(String nameProduct) {
    return http
        .get(Uri.parse(URL + servicio_pruebas + "/$nameProduct"),
            headers: headers)
        .then((data) {
      print(data);
      print('este es el resultado');
    });
  }
}
