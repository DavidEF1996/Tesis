import 'package:flutter/material.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/horarios.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';
import 'package:qr_flutter/vistas/PrincipalTarjetasCirujia.dart';

Map<String, WidgetBuilder> builAppRoutes() {
  return {
    '/tabla': (BuildContext context) => new RegisterPage(),
    '/botones': (BuildContext context) => new Botones(),
    '/horarios': (BuildContext context) => new Horarios(),
    '/principalTarjeta': (BuildContext context) => new PrincipalTarCirujias(),
  };
}
