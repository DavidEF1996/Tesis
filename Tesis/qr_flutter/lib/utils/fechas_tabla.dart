import 'package:intl/intl.dart';

int cont1;

List<DateTime> cargarFechasTabla(DateTime fechaActual, int index) {
  //print(fechaActual);
  //print(index);
  DateTime fechaAuxiliar;
  int contauxi = 1;
  List<DateTime> fechas = [];

  do {
    fechaAuxiliar = new DateTime(
        fechaActual.year, fechaActual.month, fechaActual.day - contauxi);
    contauxi = contauxi + 1;
    //print("La fecha es: " + fechaAuxiliar.toString());
    // fechaConNegrita.text = "";
    fechas.add(fechaAuxiliar);
  } while (DateFormat('EEEE').format(fechaAuxiliar).toString() != "Monday");
  print(fechas);
  print('lunes: ' + fechas[4].toString());
  print('viernes: ' + fechas[0].toString());
  return fechas;
}
