import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/src/cambioContrasena.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/registro_usuarios.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/utils/utils.dart';
import 'package:qr_flutter/utils/utils.dart' as utl;
import 'package:qr_flutter/vistas/PrincipalTarjetasCirujia.dart';

class Vista_Celular_Loguin {
  CirujiaDAO cirujia = new CirujiaDAO();
  static APIResponse<List<Cirujias>> apiResponse;
  Container vistaPortraitCelular(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController,
      UserService httpServicio,
      Responsive responsive) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Image(
            height: responsive.diagonalPorcentaje(30),
            image: AssetImage('assets/logoOperation.PNG'),
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Bienvenido',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: responsive.diagonalPorcentaje(5)),
              )),
          Container(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Usuario",
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Contraseña",
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) {
                //return CambioContrasena();

                //return CambioContrasena();
              });
              Navigator.push(context, route);
            },
            textColor: Colors.blue,
            child: Text('Olvido su contraseña'),
          ),
          Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text(
                  'Comenzar',
                  style:
                      TextStyle(fontSize: responsive.diagonalPorcentaje(2.75)),
                ),
                onPressed: () {
                  cargar(context, nameController, passwordController,
                      httpServicio);
                },
              )),
          Container(
              child: Row(
            children: <Widget>[
              Text(
                '¿No tiene una cuenta?',
                style: TextStyle(fontSize: responsive.diagonalPorcentaje(2.5)),
              ),
              FlatButton(
                textColor: Colors.blue,
                child: Text(
                  'Crear cuenta',
                  style:
                      TextStyle(fontSize: responsive.diagonalPorcentaje(2.5)),
                ),
                onPressed: () {
                  final route = MaterialPageRoute(builder: (context) {
                    return insertar_usuarios();
                  });
                  Navigator.push(context, route);
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ))
        ],
      ),
    );
  }

  Row vistaLandScapeCelular(
      Responsive responsive,
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController,
      UserService httpServicio) {
    return Row(
      children: [
        Expanded(
            child: Container(
          width: MediaQuery.of(context).size.width,
          child: Image(
            width: responsive.diagonalPorcentaje(50),
            height: responsive.diagonalPorcentaje(75),
            image: AssetImage('assets/logoOperation.PNG'),
          ),
        )),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(1),
                    child: Text(
                      'Bienvenido',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.diagonalPorcentaje(5.5)),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuario",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      //return CambioContrasena();

                      //return CambioContrasena();
                    });
                    Navigator.push(context, route);
                  },
                  textColor: Colors.blue,
                  child: Text('Olvido su contraseña'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Comenzar',
                          style: TextStyle(
                              fontSize: responsive.diagonalPorcentaje(2.75))),
                      onPressed: () {
                        // print("................................");
                        // print(apiResponse.data[0].paciente);
                        cargar(context, nameController, passwordController,
                            httpServicio);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      '¿No tiene una cuenta?',
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(2.2)),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(2.2)),
                      ),
                      onPressed: () {
                        final route = MaterialPageRoute(builder: (context) {
                          return insertar_usuarios();
                        });
                        Navigator.push(context, route);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            ),
          ),
        ))
      ],
    );
  }

  Future cargar(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController,
      UserService httpServicio) async {
    final String usuario = nameController.text;
    final String contrasena = passwordController.text;

    final result = await httpServicio.loginUsuario(
        usuario, utl.encode(passwordController.text));

    //print(result);

    if (result == null) {
      mostrarAlerta(context, "Error para acceder al servidor!");
    } else {
      if (result['acceso']) {
        if (result['bandera'] == 0) {
          final route = MaterialPageRoute(builder: (context) {
            return CambioContrasena(result['idDoctor']);
          });
          Navigator.push(context, route);
        } else {
          final _preferences = new Preferences();
          _preferences.id = result['idDoctor'];
          _preferences.nombres = UserService.usuariologueado;

          _preferences.nombresCompletos = UserService.nombres;

          _preferences.apellidos = UserService.apellidos;

          List<dynamic> datos = result['cirujias'];

          List<Cirujias> _cirujias = [];
          for (var i = 0; i < datos.length; i++) {
            Cirujias cirujia = new Cirujias();
            cirujia.idCirujia = datos.elementAt(i)['idCirujia'];
            cirujia.fechaCirujia = datos.elementAt(i)['fechaCirujia'];
            cirujia.paciente = datos.elementAt(i)['paciente'];
            _cirujias.add(cirujia);
          }
          final route = MaterialPageRoute(builder: (context) {
            return PrincipalTarCirujias();
          });
          Navigator.push(context, route);
        }
      } else {
        mostrarAlerta(context, "Error de usuario");
      }
    }

    //

    //print("object");
    //Usuario1 usu = result.data;
    //print(usu.user);
  }

  /*cargarCirujia() async {
    DateTime fechaActual = DateTime.now();
    List<DateTime> fechas = cargarFechasTabla(fechaActual, 0);

    apiResponse = await cirujia.obtenerCirujias(fechas[0], fechas[4]);
  }*/
}
