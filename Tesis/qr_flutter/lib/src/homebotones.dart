import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/cabecera.dart';
import 'package:qr_flutter/validations/usuarioLogueado.dart';

import 'package:qr_flutter/vistas/vistaCelularHomeBotones.dart';

class Botones extends StatefulWidget {
  //final String nombre;
  // const Botones({Key key, this.nombre = ""}) : super(key: key);

  @override
  _BotonesState createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  // UserService user = UserService();

  UsuarioLogueado usuariologueado = UsuarioLogueado();

  TextStyle estiloTexto = new TextStyle(fontSize: 30);

  Vista_celular vistaCelular = Vista_celular();
  String usuario;
  bool isLoaded = false;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    setState(() {
      isLoaded = true;
    });

    setState(() {
      isLoaded = false;
    });
    //nombre = (widget.nombre)
    final _preferences = new Preferences();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Cabecera(),
              Text(" "),
              usuariologueado.botonSalir(context),
            ],
          ),
        ),
      ),
      body: OrientationBuilder(builder: (_, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return isLoaded
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: vistaCelular.vistaPortraitCelular(responsive, context),
                );
        } else {
          return isLoaded
              ? CircularProgressIndicator()
              : vistaCelular.vistaLandScapeCelular(responsive, context);
        }
      }),
    );
  }
}
