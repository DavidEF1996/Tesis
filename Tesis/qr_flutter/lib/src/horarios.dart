import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/utils/fechas_tabla.dart' as FECHA;

import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/cabecera.dart';
import 'dart:core';
import 'package:qr_flutter/validations/usuarioLogueado.dart';
import 'package:intl/intl.dart';

class Horarios extends StatefulWidget {
  final int nombreQuirofano;
  const Horarios({Key key, this.nombreQuirofano = 1}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Horarios();
}

bool isloaded = false;

class _Horarios extends State<Horarios> {
  UsuarioLogueado usuariologueado = UsuarioLogueado();
  Color colorBase;
  Color colorBotonQuirofano1;
  Color colorBotonQuirofano2;
  Color colorBotonQuirofano3;
  String numeroQuirofano = "";
  TextEditingController valorFecha = TextEditingController();
  TextEditingController valorHora = TextEditingController();
  TextEditingController valorNombreDoctor = TextEditingController();
  TextEditingController fechaConNegrita = TextEditingController();
  TextEditingController horaConNegrita = TextEditingController();
  TextEditingController nombreDoctorConNegrita = TextEditingController();
  DateTime fechaActual = DateTime.now();
  int nombreQuiro;
  CirujiaDAO cirujiaDao = new CirujiaDAO();
  List indices = [];
  bool isloading = false;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
    setState(() {
      isloading = true;
      DateTime fechaActual = DateTime.now();
      List<DateTime> fechas = FECHA.cargarFechasTabla(fechaActual, 0);

      cirujiaDao.obtenerCirujias(fechas[4], fechas[0]);

      Future.delayed(const Duration(milliseconds: 3000), () {
        print('Hello, world');
        setState(() {
          isloading = false;
        });
      });
    });

    int index = 1;
    nombreQuiro = (widget.nombreQuirofano);
    nombreQuiro = (widget.nombreQuirofano == 1) ? 1 : widget.nombreQuirofano;

    cambiarColorBotonQuirofano(nombreQuiro);
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Grid List';
    final Responsive responsive = Responsive.of(context);
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: Container(
            padding: EdgeInsets.all(responsive.diagonalPorcentaje(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Cabecera(),
                Text(" "),
                usuariologueado.botonRegresar(context),
              ],
            ),
          ),
        ),
        body: isloading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                            //padding: EdgeInsets.all(responsive.diagonalPorcentaje(1)),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                RaisedButton(
                                  color: colorBotonQuirofano1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text("Quirófano 1"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    nombreQuiro = 1;
                                    cargarQuirofano(nombreQuiro, context);
                                  },
                                ),
                                RaisedButton(
                                  color: colorBotonQuirofano2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text("Quirófano 2"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    nombreQuiro = 2;
                                    cargarQuirofano(nombreQuiro, context);
                                  },
                                ),
                                RaisedButton(
                                  color: colorBotonQuirofano3,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text("Quirófano 3"),
                                      ],
                                    ),
                                  ),
                                  onPressed: () {
                                    nombreQuiro = 3;
                                    cargarQuirofano(nombreQuiro, context);
                                  },
                                ),
                                Text("     Oupado:   "),
                                Container(
                                  color: Colors.red,
                                  height: responsive.diagonalPorcentaje(3),
                                  width: responsive.diagonalPorcentaje(5),
                                ),
                                Text("  Libre:  "),
                                Container(
                                  color: Colors.blue[50],
                                  height: responsive.diagonalPorcentaje(3),
                                  width: responsive.diagonalPorcentaje(5),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: GridView.count(
                      //Codigo para la ubicación y tamaños de la grilla
                      padding: EdgeInsets.only(
                          left: responsive.diagonalPorcentaje(1),
                          right: responsive.diagonalPorcentaje(1),
                          top: responsive.diagonalPorcentaje(1)),

                      crossAxisCount: 5,
                      childAspectRatio:
                          responsive.diagonalPorcentaje(0.2), // alto de widget
                      mainAxisSpacing: responsive
                          .diagonalPorcentaje(0.2), //alto en distancia

                      crossAxisSpacing: responsive.diagonalPorcentaje(0.2),

                      //Código de la lista de widgets para la grilla
                      children: List.generate(55, (index) {
                        setState(() {
                          cabeceraTabla(index);
                          valorFecha.text =
                              cargarFechasTabla(fechaActual, index);
                          valorHora.text = cargarHorasTabla(index);
                          pintarQuirofanosOcupados(index, valorFecha.text,
                              valorHora.text, nombreQuiro);
                        });
                        return Container(
                            child: RaisedButton(
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      fechaConNegrita.text,
                                      style: TextStyle(
                                          fontSize: responsive
                                              .diagonalPorcentaje(1.2),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    textosConFecha(
                                        index, valorFecha, responsive),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      horaConNegrita.text,
                                      style: TextStyle(
                                          fontSize: responsive
                                              .diagonalPorcentaje(1.2),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    textoConHora(index, valorHora, responsive),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      nombreDoctorConNegrita.text,
                                      style: TextStyle(
                                          fontSize: responsive
                                              .diagonalPorcentaje(1.2),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    textoConNombreDoctor(
                                        index, valorNombreDoctor, responsive),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          color: colorBase,
                          onPressed: () {
                            for (var i = 0; i < indices.length; i++) {
                              if (indices[i] == index) {
                                print("Ocupado");

                                break;
                              } else if (indices[i] != index) {
                                print("Libre");

                                Navigator.of(context).pushNamed('/tabla');
                                break;
                              }
                            }
                          },
                        ));
                      }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Text textoFechaConNegrita(TextEditingController valor) {
    return Text(
      "",
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    );
  }

  Text textosConFecha(
      int index, TextEditingController valor, Responsive responsive) {
    if (valor.text == "Lunes" ||
        valor.text == "Martes" ||
        valor.text == "Miercoles" ||
        valor.text == "Jueves" ||
        valor.text == "Viernes") {
      return Text(
        valor.text,
        style: TextStyle(fontSize: responsive.diagonalPorcentaje(2.8)),
      );
    } else {
      return Text(
        valor.text,
        style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.2)),
      );
    }
  }

  Text textoConHora(
      int index, TextEditingController valor, Responsive responsive) {
    return Text(
      valor.text,
      style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.2)),
    );
  }

  Text textoConNombreDoctor(
      int index, TextEditingController valor, Responsive responsive) {
    return Text(
      valor.text,
      style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.2)),
    );
  }

  int cont1 = 0;
  String cargarFechasTabla(DateTime fechaActual, int index) {
    DateTime fechaAuxiliar;
    int contauxi = 1;

    do {
      fechaAuxiliar = new DateTime(
          fechaActual.year, fechaActual.month, fechaActual.day - contauxi);
      contauxi = contauxi + 1;
      //print("La fecha es: " + fechaAuxiliar.toString());
      fechaConNegrita.text = "";
    } while (DateFormat('EEEE').format(fechaAuxiliar).toString() != "Monday");

    if (index > 4) {
      var fechaFinal = new DateTime(
          fechaAuxiliar.year, fechaAuxiliar.month, fechaAuxiliar.day + cont1);

      var format = new DateFormat("yyyy/MM/dd");
      var dateString = format.format(fechaFinal);
      fechaConNegrita.text = "Fecha: ";

      cont1++;
      if (cont1 == 5) {
        cont1 = 0;
      }
      return dateString;
    }
  }

  int cont = 0;
  int val = 8;

  String cargarHorasTabla(int index) {
    String enviarHoraFinal;
    if (index <= 4) {
      valorHora.text = "";
      horaConNegrita.text = "";
    } else if (index >= 5 && cont <= 4) {
      enviarHoraFinal = (val).toString() + ":00";
      horaConNegrita.text = "Hora: ";
      cont++;

      if (cont == 5) {
        cont = 0;
        val = val + 1;
      }

      if (val == 18) {
        val = 8;
      }
      return enviarHoraFinal;
    }
  }

  TextEditingController cabeceraTabla(int index) {
    if (index == 0) {
      valorFecha.text = "Lunes";
      colorBase = Colors.blue[400];
    } else if (index == 1) {
      valorFecha.text = "Martes";
      colorBase = Colors.blue[400];
    } else if (index == 2) {
      valorFecha.text = "Miercoles";
      colorBase = Colors.blue[400];
    } else if (index == 3) {
      colorBase = Colors.blue[400];
      valorFecha.text = "Jueves";
    } else if (index == 4) {
      valorFecha.text = "Viernes";
      colorBase = Colors.blue[400];
    } else {
      valorFecha.text = "";
      colorBase = Colors.blue[50];
    }

    return valorFecha;
  }

  void pintarQuirofanosOcupados(
      int index, String fecha, String hora, int numeroQuirofano) {
    String horaInicio;
    String horaFin;
    int horaIntermediaAuxiliar;
    DateTime auxFecha;
    try {
      if (numeroQuirofano == 1) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          if (CirujiaDAO.recibir[i].quirofano == 1) {
            horaInicio = CirujiaDAO.recibir[i].horaInicio;
            horaFin = CirujiaDAO.recibir[i].horaFin;
            auxFecha = new DateTime.fromMillisecondsSinceEpoch(
                CirujiaDAO.recibir[i].fechaCirujia);

            var format = new DateFormat("yyyy/MM/dd");
            var dateString = format.format(auxFecha);
            horaIntermediaAuxiliar = int.parse(CirujiaDAO.recibir[i].duracion);

            String horaParaUso = horaInicio.replaceAll(":00", "");
            int horaParaUsoInt = int.parse(horaParaUso);

            for (var i = 0; i < horaIntermediaAuxiliar; i++) {
              if (fecha == dateString && hora == horaInicio.trim() ||
                  fecha == dateString && hora == horaFin.trim()) {
                colorBase = Colors.red;
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              } else {
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              }

              if (colorBase == Colors.red) {
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[0].doctores[0].nombres;
                nombreDoctorConNegrita.text = "Dr: ";
              } else {
                valorNombreDoctor.text = "";
                nombreDoctorConNegrita.text = "";
              }
            }
          }
        }
      } else if (numeroQuirofano == 2) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          if (CirujiaDAO.recibir[i].quirofano == 2) {
            horaInicio = CirujiaDAO.recibir[i].horaInicio;
            horaFin = CirujiaDAO.recibir[i].horaFin;
            auxFecha = new DateTime.fromMillisecondsSinceEpoch(
                CirujiaDAO.recibir[i].fechaCirujia);

            var format = new DateFormat("yyyy/MM/dd");
            var dateString = format.format(auxFecha);
            horaIntermediaAuxiliar = int.parse(CirujiaDAO.recibir[i].duracion);

            String horaParaUso = horaInicio.replaceAll(":00", "");
            int horaParaUsoInt = int.parse(horaParaUso);

            for (var i = 0; i < horaIntermediaAuxiliar; i++) {
              if (fecha == dateString && hora == horaInicio.trim() ||
                  fecha == dateString && hora == horaFin.trim()) {
                colorBase = Colors.red;
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              } else {
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              }

              if (colorBase == Colors.red) {
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[0].doctores[0].nombres;
                nombreDoctorConNegrita.text = "Dr: ";
                indices.add(index);
              } else {
                valorNombreDoctor.text = "";
                nombreDoctorConNegrita.text = "";
              }
            }
          }
        }
      } else if (numeroQuirofano == 3) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          if (CirujiaDAO.recibir[i].quirofano == 3) {
            horaInicio = CirujiaDAO.recibir[i].horaInicio;
            horaFin = CirujiaDAO.recibir[i].horaFin;
            auxFecha = new DateTime.fromMillisecondsSinceEpoch(
                CirujiaDAO.recibir[i].fechaCirujia);

            var format = new DateFormat("yyyy/MM/dd");
            var dateString = format.format(auxFecha);
            horaIntermediaAuxiliar = int.parse(CirujiaDAO.recibir[i].duracion);

            String horaParaUso = horaInicio.replaceAll(":00", "");
            int horaParaUsoInt = int.parse(horaParaUso);

            for (var i = 0; i < horaIntermediaAuxiliar; i++) {
              if (fecha == dateString && hora == horaInicio.trim() ||
                  fecha == dateString && hora == horaFin.trim()) {
                colorBase = Colors.red;
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              } else {
                horaParaUsoInt++;
                horaInicio = horaParaUsoInt.toString() + ":00";
              }

              if (colorBase == Colors.red) {
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[0].doctores[0].nombres;
                nombreDoctorConNegrita.text = "Dr: ";

                indices.add(index);
              } else {
                valorNombreDoctor.text = "";
                nombreDoctorConNegrita.text = "";
              }
            }
          }
        }
      }
    } on Exception catch (_) {}
  }

  void cargarQuirofano(int nombreQuirofano, BuildContext context) {
    if (nombreQuirofano == 1) {
      //cargarCirujia();
      print("Llego al quiro 1");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Horarios(
                    nombreQuirofano: 1,
                  )));
    } else if (nombreQuirofano == 2) {
      // cargarCirujia();
      print("Llego al quiro 2");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Horarios(
                    nombreQuirofano: 2,
                  )));
    } else if (nombreQuirofano == 3) {
      // cargarCirujia();
      print("Llego al quiro 3");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Horarios(
                    nombreQuirofano: 3,
                  )));
    }
  }

  void cambiarColorBotonQuirofano(int valor) {
    if (nombreQuiro == 1) {
      colorBotonQuirofano1 = Colors.greenAccent;
      colorBotonQuirofano2 = Colors.blueGrey[200];
      colorBotonQuirofano3 = Colors.blueGrey[200];
      indices = [];
    } else if (nombreQuiro == 2) {
      colorBotonQuirofano1 = Colors.blueGrey[200];
      colorBotonQuirofano2 = Colors.greenAccent;
      colorBotonQuirofano3 = Colors.blueGrey[200];
      indices = [];
    } else if (nombreQuiro == 3) {
      colorBotonQuirofano1 = Colors.blueGrey[200];
      colorBotonQuirofano2 = Colors.blueGrey[200];
      colorBotonQuirofano3 = Colors.greenAccent;
    }
  }
}
