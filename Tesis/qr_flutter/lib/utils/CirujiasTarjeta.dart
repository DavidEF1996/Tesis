import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/utils/responsive.dart';

class CardCirujias extends StatelessWidget {
  Cirujias noticias;
  CardCirujias(this.noticias);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            image: DecorationImage(
              image: AssetImage('./assets/logoSinFondo.png'),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
            )),
        height: responsive.diagonalPorcentaje(20),
        child: InkWell(
          onTap: () {},
          child: Card(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                padding(Text(noticias.procedimiento.toString(),
                    style: TextStyle(
                      fontSize: responsive.diagonalPorcentaje(2.5),
                      fontWeight: FontWeight.bold,
                    ))),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                            text: "Cirujano Principal: ",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(2),
                                fontWeight: FontWeight.bold),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: utf8.decode(
                                      latin1.encode(noticias.doctores
                                              .elementAt(0)
                                              .nombres +
                                          " " +
                                          noticias.doctores
                                              .elementAt(0)
                                              .apellidos),
                                      allowMalformed: true),
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(1.8)))
                            ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                            text: "Cirujano Ayudante: ",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(2),
                                fontWeight: FontWeight.bold),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: utf8.decode(
                                      latin1.encode(noticias.doctores
                                              .elementAt(1)
                                              .nombres +
                                          " " +
                                          noticias.doctores
                                              .elementAt(1)
                                              .apellidos),
                                      allowMalformed: true),
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(1.8)))
                            ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                            text: "Fecha: ",
                            style: TextStyle(
                                fontSize: responsive.diagonalPorcentaje(2),
                                fontWeight: FontWeight.bold),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: convertirFecha(noticias.fechaCirujia),
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(1.8)))
                            ]),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(5),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                  text: "Hora Inicio: ",
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(2),
                                      fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: noticias.horaInicio,
                                        style: TextStyle(
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)))
                                  ]),
                            ),
                            Text.rich(
                              TextSpan(
                                  text: "Hora Fin: ",
                                  style: TextStyle(
                                      fontSize:
                                          responsive.diagonalPorcentaje(2),
                                      fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text: noticias.horaFin,
                                        style: TextStyle(
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)))
                                  ]),
                            ),
                          ],
                        ))
                  ],
                )
                //  ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget padding(Widget widget) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: widget,
    );
  }

  String convertirFecha(int fecha) {
    DateTime fechaProcedimiento =
        new DateTime.fromMillisecondsSinceEpoch(fecha);
    String aux = fechaProcedimiento.toString();
    String enviar = aux.substring(0, 10);
    return enviar;
  }
}
