import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';

class CirujiaDAO {
  static const String IP = '192.168.18.4'; //'192.168.18.4';'192.168.10.118'

  static const int PORT = 8080;
  static const String servicio_listar = "/cirujias";
  static const String servicio_crear = "/insertarCirujia";
  static List<Cirujias> recibir = [];

  static const String URL =
      // 'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';
      'http://$IP:$PORT/TesisOP/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};

  static Future crearCirujia(json) async {
    http.Response response = await http.post(URL + servicio_crear,
        body: json, headers: headers, encoding: Encoding.getByName('utf-8'));

    print(response.body);

    return response;
  }

  Future listarCirujias() async {
    final response = await http.get(URL + servicio_listar,
        headers: {"Content-Type": "application/json"});
    List<dynamic> cirujia = jsonDecode(response.body);
    //  print('lista');
    //  print(cirujia);

//    cirujia

    /* List<Cirujias> listaCirujias;
    for (var i = 0; i < cirujia.length; i++) {
      Cirujias cirujiaP = new Cirujias();

      cirujiaP.paciente = (cirujia.elementAt(i)['paciente']);

      List<dynamic> numeroDoctores = cirujia.elementAt(i)['doctores'];

      cirujiaP.doctores = [];
      for (var j = 0; j < numeroDoctores.length; j++) {
        Doctore doctor = new Doctore();
        doctor.nombres = numeroDoctores.elementAt(j)['nombres'];

        cirujiaP.doctores.add(doctor);
      }

      listaCirujias.add(cirujiaP);
    }*/

    return cirujia;
  }

  Future<APIResponse<List<Cirujias>>> obtenerCirujias() {
    return http.get(URL + servicio_listar,
        headers: {"Content-Type": "application/json"}).then((data) {
      log('La respuesta obtenida es -----------: ' + data.body);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final cirujiaL = <Cirujias>[];
        for (var item in jsonData) {
          cirujiaL.add(Cirujias.fromJson(item));
        }
        recibir = cirujiaL;
        return APIResponse<List<Cirujias>>(data: cirujiaL);
      }
      return APIResponse<List<Cirujias>>(error: true, mensajeError: "Error");
    }).catchError(
        (_) => APIResponse<List<Cirujias>>(error: true, mensajeError: "Error"));
  }

  String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    var diff = date.difference(now);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);

      print("----------");
      print("----------");
    } else {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + 'DAY AGO';
      } else {
        time = diff.inDays.toString() + 'DAYS AGO';
      }
    }

    return time;
  }
}
