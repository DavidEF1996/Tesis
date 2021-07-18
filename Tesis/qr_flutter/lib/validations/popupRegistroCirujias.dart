import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/dao/doctor_dao.dart';
import 'package:qr_flutter/utils/utils.dart';
import 'package:qr_flutter/vistas/PrincipalTarjetasCirujia.dart';

final CirujiaDAO serviciosCirujia = CirujiaDAO();

class popupRegistroCirujias {
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
    Cirujias r,
    BuildContext context,
  ) async {
    // print(r.doctores.);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirme los datos antes de enviar'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      'Nombres: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.paciente), //cedula.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Fecha de Nacimiento: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.fechaNacimiento
                        .toString()
                        .substring(0, 10)), //nombres.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Años: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.anios.toString()), //apellidos.text),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Meses: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.meses
                        .toString()), ////currentDate.year.toString() + "/" +  currentDate.month.toString() + "/" +   currentDate.day.toString()),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Tipo de Cirugía: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.tipoCirujia), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombre enfermedad: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.diagnostico.nombreCuatroCaracteres
                        .toString()), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'F. Pro: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(DateTime.fromMillisecondsSinceEpoch(r.fechaCirujia)
                        .toString()), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Horas requeridas: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.duracion), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Necesidad de Sangre: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.necesidadSangre), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Exámenes de Sangre: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.examenSangre), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Radiografías de Torax: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.examenTorax.toString()), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Examen ECG: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.crjEcj.toString()), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Cuantitativos Covid-19: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(r.covid.toString()), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombre del Cirujano: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(""), //.text),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Nombre del Ayudante: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(""), //.text),
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
                validarCirujia(context, r);
                // print("Nombres: " + r.paciente);
                // await RegistroCirujias.crearDoctor(jsonEncode(r.toJson()()));
                // print("Usuario desde el popup: " + DoctorDao.d.user);

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

  Future validarCirujia(context, Cirujias cirujia) async {
    print("llegamos al validar");
    final servicio =
        await serviciosCirujia.crearCirujia(jsonEncode(cirujia.toJson()));
    print(servicio.toString());
    if (servicio == 200) {
      mostrarAlerta(context, "Se ha registrado con éxito la ciurjía.");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PrincipalTarCirujias()));
    } else if (servicio == 100) {
      mostrarAlerta(context,
          "Error Hay un conflicto con el horario. Elija otro horario u otro quirófano ");
    } else if (servicio == 250) {
      mostrarAlerta(context,
          "Ha ingresado una cirujía de emergencia \n Revise el nuevo calendario");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => PrincipalTarCirujias()));
    }
  }
}
