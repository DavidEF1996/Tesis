import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/dao/doctor_dao.dart';
import 'package:qr_flutter/model/change_password.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/validations/popupRegistroUsuarios.dart';
import 'package:qr_flutter/utils/utils.dart';
import 'package:qr_flutter/preferences/preferences.dart';

class CambioContrasena extends StatefulWidget {
  final String id;
  CambioContrasena(this.id);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<CambioContrasena> {
  String _id;
  @override
  void initState() {
    _id = widget.id;
    super.initState();
  }

  TextEditingController nuevaContrasena = TextEditingController();
  TextEditingController repNuevaContrasena = TextEditingController();
  popupRegistroUsuario popRegUsuario = popupRegistroUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
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
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: nuevaContrasena,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Escriba su nueva contraseña aquí",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: repNuevaContrasena,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Repita la contraseña",
                    ),
                    onTap: () {
                      if (nuevaContrasena != repNuevaContrasena) {
                        return "Las contraseñas no coinciden";
                      } else {
                        return "";
                      }
                    },
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Enviar'),
                      onPressed: () {
                        enviar(context, _id, repNuevaContrasena.text);
                      },
                    )),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Cancelar'),
                      onPressed: () {
                        final route = MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        });
                        Navigator.pushReplacement(context, route);
                      },
                    )),
              ],
            )));
  }

  Future enviar(BuildContext context, String id, String pass) async {
    if (nuevaContrasena.text != repNuevaContrasena.text) {
      popRegUsuario.handleClickMe(context, 'Las contraseñas no coinciden');
    } else if (nuevaContrasena.text == repNuevaContrasena.text) {
      print(id);
      Changepass c = Changepass();
      c.idDoctor = id;
      c.password = pass;
      final resultado = await DoctorDao.changePass(jsonEncode(c.toJson()));
      // String valor = resultado;
      print(resultado.toString());
      if (resultado) {
        final _preferences = new Preferences();
        _preferences.id = null;
        final route = MaterialPageRoute(builder: (context) {
          return LoginPage();
        });
        Navigator.pushReplacement(context, route);
      } else {
        mostrarAlerta(context, "Error de acceso");
      }
    }
  }
}
