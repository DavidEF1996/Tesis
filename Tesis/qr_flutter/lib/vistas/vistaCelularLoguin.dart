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

class Vista_Celular_Loguin {
  CirujiaDAO cirujia = new CirujiaDAO();
  static APIResponse<List<Cirujias>> apiResponse;
  Container vistaPortraitCelular(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController passwordController,
      UserService httpServicio) {
    print("LLegue a portrait");
    return Container(
        child: ListView(
      children: <Widget>[
        Image(
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
                  fontSize: 30),
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
              child: Text('Comenzar'),
              onPressed: () {
                print("LLegue a comenzar");
                cargarCirujia();
                cargar(
                    context, nameController, passwordController, httpServicio);
              },
            )),
        Container(
            child: Row(
          children: <Widget>[
            Text('¿No tiene una cuenta?'),
            FlatButton(
              textColor: Colors.blue,
              child: Text(
                'Crear cuenta',
                style: TextStyle(fontSize: 20),
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
    ));
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
          child: Image(
            width: responsive.diagonalPorcentaje(50),
            height: responsive.diagonalPorcentaje(75),
            image: AssetImage('assets/logoOperation.PNG'),
          ),
        )),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Bienvenido',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
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
                      child: Text('Comenzar'),
                      onPressed: () {
                        cargarCirujia();
                        // print("................................");
                        // print(apiResponse.data[0].paciente);
                        cargar(context, nameController, passwordController,
                            httpServicio);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('¿No tiene una cuenta?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(fontSize: 20),
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

    print(result);

    print((result['acceso']));
    if (result['acceso']) {
      if (result['bandera'] == 0) {
        final route = MaterialPageRoute(builder: (context) {
          return CambioContrasena(result['idDoctor']);
        });
        Navigator.push(context, route);
      } else {
        //print(result['idDoctor']);

        final _preferences = new Preferences();
        _preferences.id = result['idDoctor'];
        _preferences.nombres = UserService.usuariologueado;
        final route = MaterialPageRoute(builder: (context) {
          return Botones();
        });
        Navigator.push(context, route);
      }
    } else {
      mostrarAlerta(context, "Error de usuario");
    }

    //

    //print("object");
    //Usuario1 usu = result.data;
    //print(usu.user);
  }

  cargarCirujia() async {
    apiResponse = await cirujia.obtenerCirujias();
  }
}
