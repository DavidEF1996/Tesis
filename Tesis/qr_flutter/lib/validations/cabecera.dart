import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/utils/responsive.dart';

class Cabecera extends StatelessWidget {
  const Cabecera({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final _preferences = new Preferences();

    final Responsive responsive = Responsive.of(context);
    if (data.orientation == Orientation.portrait) {
      return Container(
          child: Text.rich(
        TextSpan(
            text: "Bienvenido: ",
            style: TextStyle(
                fontSize: responsive.diagonalPorcentaje(2.5),
                fontWeight: FontWeight.bold),
            children: <InlineSpan>[
              TextSpan(
                  text: utf8.decode(latin1.encode(_preferences.nombres),
                      allowMalformed: true),
                  style:
                      TextStyle(fontSize: responsive.diagonalPorcentaje(2.2)))
            ]),
      ));
    } else {
      return Container(
          child: Text.rich(
        TextSpan(
            text: "Bienvenido: ",
            style: TextStyle(
                fontSize: responsive.diagonalPorcentaje(3.5),
                fontWeight: FontWeight.bold),
            children: <InlineSpan>[
              TextSpan(
                  text: utf8.decode(latin1.encode(_preferences.nombres),
                      allowMalformed: true),
                  style: TextStyle(fontSize: responsive.diagonalPorcentaje(3)))
            ]),
      ));
    }
  }
}
