import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/login.dart';

class UsuarioLogueado {
  final _preferences = new Preferences();
  Text userloguin2() => Text("Usuario: ",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13));
  Text userloguin() =>
      Text(_preferences.nombres, style: TextStyle(fontSize: 13));

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

  FloatingActionButton botonRegresar(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text(
        '',
      ),
      icon: Icon(Icons.arrow_left),
      onPressed: () {
        // PersonaDAO.eliminarPersona(widget.persona.getID);
        final _preferences = new Preferences();
        _preferences.id = "";
        final route = MaterialPageRoute(builder: (context) {
          return Botones();
        });
        Navigator.pushReplacement(context, route);
      },
    );
  }
}
