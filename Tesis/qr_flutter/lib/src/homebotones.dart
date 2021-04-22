import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/usuarioLogueado.dart';

import 'package:qr_flutter/vistas/vistaCelularHomeBotones.dart';

class Botones extends StatefulWidget {
  //final String nombre;
  // const Botones({Key key, this.nombre = ""}) : super(key: key);

  @override
  _BotonesState createState() => _BotonesState();
}

class _BotonesState extends State<Botones> {
  UserService user = UserService();

  UsuarioLogueado usuariologueado = UsuarioLogueado();

  TextStyle estiloTexto = new TextStyle(fontSize: 30);

  Vista_celular vistaCelular = Vista_celular();
  String usuario;
  @override
  void initState() {
    super.initState();
    //nombre = (widget.nombre)
    final _preferences = new Preferences();
    print("-------");
    print(_preferences.id);
    print(_preferences.nombres);
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
              Text(
                "Bienvenido    ",
                style: TextStyle(fontSize: 17),
              ),
              Container(
                child: Row(
                  children: [
                    usuariologueado.UserLoguinCabeceraPortrait(),
                    usuariologueado.UserLoguinPortrait(),
                  ],
                ),
              ),
              Text("  "),
              usuariologueado.botonSalir(context),
            ],
          ),
        ),
      ),
      body: OrientationBuilder(builder: (_, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          return SingleChildScrollView(
            child: vistaCelular.vistaPortraitCelular(responsive, context),
          );
        } else {
          return vistaCelular.vistaLandScapeCelular(responsive, context);
        }
      }),
    );
  }
}
