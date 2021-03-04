import 'package:flutter/material.dart';
import 'package:qr_flutter/src/registro_usuarios.dart';
import 'package:flutter/cupertino.dart';

class popupRegistroUsuario {
  Future<void> handleClickMe(BuildContext context, String mensaje) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(mensaje),

          // Text(nombres.text + " " + apellidos.text),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> menuConfirmacionDatos(
      BuildContext context,
      TextEditingController cedula,
      TextEditingController nombres,
      TextEditingController apellidos,
      TextEditingController idDoctor,
      TextEditingController especialidad,
      DateTime currentDate) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirme los datos antes de enviar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Cédula: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(cedula.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombres: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(nombres.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Apellidos: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(apellidos.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Fecha de Nacimiento: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(currentDate.year.toString() +
                        "/" +
                        currentDate.month.toString() +
                        "/" +
                        currentDate.day.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'ID del Doctor: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(idDoctor.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Especialidad: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(especialidad.text),
                  ],
                ),
              ],
            ),
          ),
          // Text(nombres.text + " " + apellidos.text),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop();
                enviarDatos(context, cedula, nombres, apellidos, idDoctor,
                    especialidad, currentDate);
              },
            ),
          ],
        );
      },
    );
  }

  void enviarDatos(
      BuildContext context,
      TextEditingController cedula,
      TextEditingController nombres,
      TextEditingController apellidos,
      TextEditingController idDoctor,
      TextEditingController especialidad,
      DateTime currentDate) {
    print("Datos enviados-----------------------------");
    print("E. Cédula: " + cedula.text);
    print("E. Nombres:  " + nombres.text);
    print("E. Apellidos: " + apellidos.text);
    print("E. Id Doctor: " + idDoctor.text);
    print("E. Especialidad: " + especialidad.text);
    String fecha = currentDate.year.toString() +
        "/" +
        currentDate.month.toString() +
        "/" +
        currentDate.day.toString();
    print("E. Fecha de nacimiento: " + fecha);
    print("------------------------------------------");
    final route = MaterialPageRoute(builder: (context) {
      return insertar_usuarios();
    });
    Navigator.push(context, route);
  }

  calcularEdadGeneral(DateTime value, int age, int months) {
    DateTime currentDate = DateTime.now();
    print("actual" + currentDate.year.toString());
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;

    if (month2 > month1) {
      months = 12 - (month2 - month1);
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = value.day;
      if (day2 > day1) {
        age--;
      }
    }
    print("age: " + age.toString());
    print("months: " + months.toString());
  }
}
