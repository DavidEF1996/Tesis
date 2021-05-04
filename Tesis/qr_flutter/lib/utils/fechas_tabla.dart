import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Fecha_Tabla {
  List<DateTime> obtenerFechasSemana(DateTime fechaActual) {
    //print(fechaActual);
    //print(index);
    int cont1 = 1;
    DateTime fechaAuxiliar;
    int contauxi = 0;
    List<DateTime> fechas = [];

    do {
      fechaAuxiliar = new DateTime(
          fechaActual.year, fechaActual.month, fechaActual.day - contauxi);
      contauxi = contauxi + 1;
      //print("La fecha es: " + fechaAuxiliar.toString());
      // fechaConNegrita.text = "";

    } while (DateFormat('EEEE').format(fechaAuxiliar).toString() != "Monday");
    print(fechaAuxiliar.toIso8601String());
    fechas.add(fechaAuxiliar);
    while (cont1 < 5) {
      var fechaFinal = new DateTime(
          fechaAuxiliar.year, fechaAuxiliar.month, fechaAuxiliar.day + cont1);
      fechas.add(fechaFinal);
      cont1++;
    }
    //print('lunes: ' + fechas[4].toString());
    //print('viernes: ' + fechas[0].toString());
    print(fechas.length);
    print(fechas.toString());
    return fechas;
  }
}
