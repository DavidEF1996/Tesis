import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'dart:convert';

import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/src/login.dart';

class UsuarioLogueado {
  Text userloguin2() => Text("Usuario: ",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13));
  Text userloguin() =>
      Text(UserService.usuariologueado, style: TextStyle(fontSize: 13));

  FloatingActionButton botonSalir(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        '',
      ),
      icon: Icon(Icons.power_settings_new),
      onPressed: () {
        // PersonaDAO.eliminarPersona(widget.persona.getID);
        final _preferences = new Preferences();
        _preferences.id = "";
        final route = MaterialPageRoute(builder: (context) {
          return LoginPage();
        });
        Navigator.pushReplacement(context, route);
      },
    );
  }
}
