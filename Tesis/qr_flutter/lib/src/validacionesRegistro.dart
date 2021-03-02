import 'package:flutter/material.dart';
import 'package:qr_flutter/src/registro_usuarios.dart';
import 'package:flutter/cupertino.dart';

class Validaciones {
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  //TextEditingController parametro = new TextEditingController();
  String validatePassword(String value, String parametro) {
    print("Repas" + value);
    print("Contra" + parametro);
    if (value != parametro) {
      print("Son diferentes");
      return "Las contraseñas no coinciden";
    } else {
      print("Son iguales");
      print("Repas" + value);
      print("Contra" + parametro);
      return null;
    }
  }

  String validateName(String value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El campo debe contener solo letras";
    }
    return null;
  }

  String validarCamposVacios(String value) {
    if (value.length == 0) {
      return "El campo es necesario";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El telefono es necesariod";
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  bool validarCedula(String cedula) {
    int digito = -1;
    int suma = 0;
    int resta = -1;

    for (int i = 0; i < cedula.length; i++) {
      digito = cedula.codeUnitAt(i) - 48;
      if (i % 2 == 0) digito = (digito * 2) > 9 ? (digito * 2) - 9 : digito * 2;

      if (i < cedula.length - 1) suma += digito;
    }
    suma = suma % 10;
    resta = (digito == 0) ? suma : 10 - suma;
    return (resta == digito);
  }

  Future redireccionar(BuildContext context) async {
    Navigator.of(context).pushNamed('/Botones');
  }

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
}
