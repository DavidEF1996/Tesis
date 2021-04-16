import 'package:flutter/material.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/model/doctor.dart';
import 'package:qr_flutter/dao/doctor_dao.dart';
import 'dart:convert';

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
    Doctor d,
    BuildContext context,
  ) async {
    print(d.cedula);
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
                    Text(d.cedula), //cedula.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombres: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(d.nombres), //nombres.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Apellidos: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(d.apellidos), //apellidos.text),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fecha de Nacimiento: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(d.fechaNacimiento.toString().substring(0,
                        4)), ////currentDate.year.toString() + "/" +  currentDate.month.toString() + "/" +   currentDate.day.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'ID del Doctor: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(d.idDoctor), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Especialidad: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(d.especialidad), //.text),
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
              onPressed: () async {
                String decodePassword = d.password;
                print(d.password + "contrase;a");
                await DoctorDao.crearDoctor(jsonEncode(d.toJson()));
                final String outputUser = utf8.decode(
                    latin1.encode(DoctorDao.d.user),
                    allowMalformed: true);

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage(
                              usuario: outputUser,
                              contrasena: decodePassword,
                            )));

                //enviarDatos(context);
              },
            ),
          ],
        );
      },
    );
  }

  void enviarDatos(
    BuildContext context,
  ) {
    final route = MaterialPageRoute(builder: (context) {
      return LoginPage(
        usuario: DoctorDao.d.user,
        contrasena: "contrasena",
      );
    });
    Navigator.push(context, route);
  }
}
