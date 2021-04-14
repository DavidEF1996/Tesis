import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'dart:core';
import 'package:qr_flutter/validations/usuarioLogueado.dart';
import 'package:intl/intl.dart';

/// This is the stateless widget that the main application instantiates.
class Horarios extends StatefulWidget {
  final String nombreQuirofano;
  const Horarios({Key key, this.nombreQuirofano = ""}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Horarios();
}

class _Horarios extends State<Horarios> {
  //variables usadas en los diferentes métodos
  UsuarioLogueado usuariologueado = UsuarioLogueado();
  int index = 1;
  Color colorBase;
  String numeroQuirofano = "";
  TextEditingController valorFecha = TextEditingController();
  TextEditingController valorHora = TextEditingController();
  DateTime fechaActual = DateTime.now();
  String nombreQuiro;

  @override
  void initState() {
    super.initState();

    nombreQuiro = (widget.nombreQuirofano);
    nombreQuiro =
        (widget.nombreQuirofano == "") ? "Quirófano 1" : widget.nombreQuirofano;
    print("El nombre con que inicia es: " + nombreQuiro);
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
     ]);
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    final Responsive responsive = Responsive.of(context);
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: new AppBar(
          title: Container(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Text(
                  "Bienvenido    ",
                  style: TextStyle(fontSize: 17),
                ),
                usuariologueado.userloguin2(),
                usuariologueado.userloguin(),
                Text("   "),
                usuariologueado.botonRegresar(context),
              ],
            ),
          ),
        ),
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(1)),
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        children: [
                          RaisedButton(
                            child: Container(
                              child: Column(
                                children: [
                                  Text("Quirófano 1"),
                                ],
                              ),
                            ),
                            onPressed: () {
                              nombreQuiro = "Quirófano 1";
                              crear(nombreQuiro);
                            },
                          ),
                          RaisedButton(
                            child: Container(
                              child: Column(
                                children: [
                                  Text("Quirófano 2"),
                                ],
                              ),
                            ),
                            onPressed: () {
                              //nombreQuirofano = "Quirófano 2";
                              nombreQuiro = "Quirófano 2";
                              crear(nombreQuiro);
                            },
                          ),
                          RaisedButton(
                            child: Container(
                              child: Column(
                                children: [
                                  Text("Quirófano 3"),
                                ],
                              ),
                            ),
                            onPressed: () {
                              // crear();
                            },
                          ),
                          Text("Oupado:   "),
                          Container(
                            color: Colors.yellow,
                            height: responsive.diagonalPorcentaje(3),
                            width: responsive.diagonalPorcentaje(5),
                          ),
                          Text("  Libre:  "),
                          Container(
                            color: Colors.brown,
                            height: responsive.diagonalPorcentaje(3),
                            width: responsive.diagonalPorcentaje(5),
                          ),
                        ],
                      )),
                  /*Container(
                    padding: EdgeInsets.all(responsive.diagonalPorcentaje(1.5)),
                    child: Row(
                      children: [
                        Container(
                          child: Row(
                            children: [],
                          ),
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
            new Expanded(
              child: GridView.count(
                //Codigo para la ubicación y tamaños de la grilla
                padding: EdgeInsets.only(
                    left: responsive.diagonalPorcentaje(1),
                    right: responsive.diagonalPorcentaje(10),
                    top: responsive.diagonalPorcentaje(1)),

                crossAxisCount: 5,
                childAspectRatio:
                    responsive.diagonalPorcentaje(0.2), // alto de widget
                mainAxisSpacing:
                    responsive.diagonalPorcentaje(0.2), //alto en distancia
                crossAxisSpacing: responsive.diagonalPorcentaje(0.2),

                //Código de la lista de widgets para la grilla

                children: List.generate(55, (index) {
                  setState(() {
                    _cabeceras(index);

                    valorFecha.text = fechas(fechaActual, index);
                    horas(fechaActual, index);

                    pintarOcupados(
                        index, valorFecha.text, valorHora.text, nombreQuiro);
                  });
                  // _valores(index);

                  return Container(
                      child: RaisedButton(
                    child: Container(
                      width: responsive.anchoPorcentaje(100),

                      //height: responsive.diagonalPorcentaje(7),
                      child: Column(
                        children: [
                          textos(index, valorFecha),
                          Text(valorHora.text)
                        ],
                      ),
                    ),
                    color: colorBase,
                    onPressed: () {
                      // print(nombreQuirofano);
                    },
                  ));
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text textos(int index, TextEditingController valor) {
    if (valor.text == "Lunes" ||
        valor.text == "Martes" ||
        valor.text == "Miercoles" ||
        valor.text == "Jueves" ||
        valor.text == "Viernes") {
      return Text(
        valor.text,
        style: TextStyle(fontSize: 17),
      );
    } else {
      return Text(
        valor.text,
        style: TextStyle(fontSize: 12),
      );
    }
  }

  int cont1 = 0;
  String fechas(DateTime fechaActual, int index) {
    DateTime fechaAuxiliar;
    int contauxi = 1;

    do {
      fechaAuxiliar = new DateTime(
          fechaActual.year, fechaActual.month, fechaActual.day - contauxi);
      contauxi = contauxi + 1;
      //print("La fecha es: " + fechaAuxiliar.toString());
    } while (DateFormat('EEEE').format(fechaAuxiliar).toString() != "Monday");

    if (index > 4) {
      var fechaFinal = new DateTime(
          fechaAuxiliar.year, fechaAuxiliar.month, fechaAuxiliar.day + cont1);
      String enviarFechaFinal = fechaFinal.year.toString() +
          "/" +
          fechaFinal.month.toString() +
          "/" +
          fechaFinal.day.toString();

      cont1++;
      if (cont1 == 5) {
        cont1 = 0;
      }
      return enviarFechaFinal;
    }
  }

  int cont = 0;
  int val = 7;
  String horas(DateTime fecha, int index) {
    if (index >= 5 && cont % 5 == 0) {
      valorHora.text = (val + 1).toString();
      cont++;
      val++;
    } else if (index > 5 && cont % 5 != 0) {
      valorHora.text = val.toString();
      cont++;
    }
  }

  TextEditingController _cabeceras(int index) {
    if (index == 0) {
      valorFecha.text = "Lunes";
      colorBase = Colors.blueGrey;
    } else if (index == 1) {
      valorFecha.text = "Martes";
      colorBase = Colors.blueGrey;
    } else if (index == 2) {
      valorFecha.text = "Miercoles";
      colorBase = Colors.blueGrey;
    } else if (index == 3) {
      colorBase = Colors.blueGrey;
      valorFecha.text = "Jueves";
    } else if (index == 4) {
      valorFecha.text = "Viernes";
      colorBase = Colors.blueGrey;
    } else {
      valorFecha.text = "";
      colorBase = Colors.yellow;
    }

    return valorFecha;
  }

  void pintarOcupados(
      int index, String fecha, String hora, String numeroQuirofano) {
    if (numeroQuirofano == "Quirófano 1") {
      if (fecha == "2021/4/10" && hora == "9") {
        colorBase = Colors.white;
      }

      if (fecha == "2021/4/10" && hora == "10") {
        colorBase = Colors.white;
      }
    } else if (numeroQuirofano == "Quirófano 2") {
      if (fecha == "2021/4/11" && hora == "8") {
        colorBase = Colors.white;
      }

      if (fecha == "2021/4/11" && hora == "9") {
        colorBase = Colors.white;
      }
    }
  }

  void crear(String nombreQuirofano) {
    if (nombreQuirofano == "Quirófano 1") {
      print("Llego al quiro 1");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Horarios(
                    nombreQuirofano: "Quirófano 1",
                  )));
    } else if (nombreQuirofano == "Quirófano 2") {
      print("Llego al quiro 2");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Horarios(
                    nombreQuirofano: "Quirófano 2",
                  )));
    }
  }
}
