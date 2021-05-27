import 'package:qr_flutter/dao/cirujiaDao.dart';

class IndiceCreador {
  int indiceCreadorCalendario(int quirofano) {
    int horaFin;
    int horaTope = 18;
    int parametroCreacionCalendario = 84;

    for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
      horaFin = int.parse(CirujiaDAO.recibir[i].horaFin.replaceAll(":00", ""));

      int guardarCaso1 = 0;

      if (horaFin > horaTope && CirujiaDAO.recibir[i].quirofano == quirofano) {
        guardarCaso1 = horaFin - horaTope;
        parametroCreacionCalendario = 84 + (guardarCaso1 * 7);
        print(parametroCreacionCalendario);
      } else {}
    }
    return parametroCreacionCalendario;
  }
}
