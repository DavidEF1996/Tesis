class Conn {
  static const String IP = '192.168.18.9'; //'192.168.18.4';'192.168.10.118'2

  static const int PORT = 8080;
  static const String URL =
      'http://$IP:$PORT/operatingRoomRs/ws/operatingRoomServices';
  // 'http://$IP:$PORT/TesisOP/ws/operatingRoomServices';

  static const String URL_PYTHON = "http://$IP:5000";
}
