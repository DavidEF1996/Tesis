import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/utils/fechas_tabla.dart';

class UsuarioLogueado {
  final _preferences = new Preferences();
  Text UserLoguinCabeceraLandsCape() => Text("Usuario: ",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
  Text UserLoguinLandsCape() =>
      Text(_preferences.nombres, style: TextStyle(fontSize: 18));

  Text UserLoguinCabeceraPortrait() => Text("Usuario: ",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14));
  Text UserLoguinPortrait() =>
      Text(_preferences.nombres, style: TextStyle(fontSize: 14));

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
      icon: Icon(Icons.arrow_left),
      label: Text(
        'Regresar',
      ),
      onPressed: () {
        // PersonaDAO.eliminarPersona(widget.persona.getID);
        final _preferences = new Preferences();
        _preferences.id = "";
        Navigator.of(context).pushNamed('/botones');
      },
    );
  }
}
