import 'dart:convert';
import 'package:http/http.dart' as http;

class DoctorDao {
  static const String IP = '192.168.18.4';
  static const int PORT = 8080;
  static const String servicio = "/crear";
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices$servicio';

  static const headers = {'Content-Type': 'application/json'};

  static Future crearDoctor(json) async {
    print("dao");
    print(json.toString());
    http.Response response = await http.post(URL,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));
    print(response.body);
    return response;
  }
}
