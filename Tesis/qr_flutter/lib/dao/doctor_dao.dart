import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorDao {
  static const String IP = '192.168.18.9';
  static const int PORT = 8080;
  static const String servicio_crear = "/crear";
  static const String servicio_login = "/login";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};

  static Future crearDoctor(json) async {
    print("dao");
    print(json.toString());
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print(response.body);
    return response;
  }

  static Future login(json) async {
    http.Response response = await http.post(URL + servicio_login,
        body: json, headers: headers, encoding: Encoding.getByName("utf-8"));
    print(response);
    return response;
  }
}
