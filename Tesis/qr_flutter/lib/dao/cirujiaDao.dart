import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/cirujiasPrincipal.dart';

class CirujiaDAO {
  static const String IP = '192.168.100.4'; //'192.168.18.4';'192.168.10.118'
  //static const String IP = '192.168.100.8'; //'192.168.18.4';'192.168.10.118'

  static const int PORT = 8080;
  static const String servicio_crear = "/cirujias";

  static const String URL =
      // 'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';
      'http://$IP:$PORT/TesisOP/ws/operatingRoomServices';

  static const headers = {'Content-Type': 'application/json'};

  Future listarCirujias() async {
    final response = await http.get(URL + servicio_crear,
        headers: {"Content-Type": "application/json"});
    List<dynamic> cirujia = jsonDecode(response.body);

    List<Cirujias> listaCirujias = [];

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
    }
    return listaCirujias;
  }
}
