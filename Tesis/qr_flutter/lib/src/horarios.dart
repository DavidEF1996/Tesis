import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/modeloDatosCirujia.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';
import 'package:qr_flutter/utils/fechas_tabla.dart';

import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/IndiceCreadorCalendario.dart';
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
  List<DatosCirujia> datosCirujia = [];
  //bool isloading = false;
  List<DateTime> fechas = [];
  Fecha_Tabla fecha_tabla = new Fecha_Tabla();
  Preferences preferences = new Preferences();
  IndiceCreador inCreador = new IndiceCreador();
  int indiceParaCalendario;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();

    int index = 1;
    nombreQuiro = (widget.nombreQuirofano);
    nombreQuiro = (widget.nombreQuirofano == 1) ? 1 : widget.nombreQuirofano;
    indiceParaCalendario = inCreador.indiceCreadorCalendario(nombreQuiro);
    print("Esta vez es" + indiceParaCalendario.toString());
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
        body: // isloading
            //  ? CircularProgressIndicator()
            //:
            Container(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                  height: responsive.diagonalPorcentaje(7),
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 7,
                      childAspectRatio:
                          responsive.diagonalPorcentaje(0.25), // alto de widget
                      //alto en distancia

                      crossAxisSpacing: responsive.diagonalPorcentaje(0.01),
                      children: List.generate(7, (index2) {
                        setState(() {
                          diasSemana(index2);
                        });
                        return //Container(
                            // width: MediaQuery.of(context).size.width,
                            //child:
                            InkWell(
                          child: Card(
                            color: Colors.blue[400],
                            child: Center(
                              child: tamanoLetraDiasSemana(
                                  index2, valorFecha, responsive),
                            ),
                          ),
                        );
                        //
                        // );
                      }))),
              Expanded(
                child: GridView.count(
                  //Codigo para la ubicación y tamaños de la grilla

                  crossAxisCount: 7,
                  childAspectRatio:
                      responsive.diagonalPorcentaje(0.15), // alto de widget
                  mainAxisSpacing:
                      responsive.diagonalPorcentaje(0.50), //alto en distancia

                  crossAxisSpacing: responsive.diagonalPorcentaje(0.15),

                  //Código de la lista de widgets para la grilla
                  children: List.generate(indiceParaCalendario, (index) {
                    setState(() {
                      colorBaseQuirofanosVacios(index);
                      valorFecha.text = cargarFechasTabla(fechaActual, index);
                      valorHora.text = cargarHorasTabla(index);
                      pintarQuirofanosOcupados(
                          index, valorFecha.text, valorHora.text, nombreQuiro);
                    });
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: EdgeInsets.all(0),
                        width: responsive.diagonalPorcentaje(12.5),
                        child: InkWell(
                            onTap: () {
                              print(index);
                              /* for (var i = 0; i < datosCirujia.length; i++) {
                                print("Los datos son: " +
                                    datosCirujia[i].indice.toString() +
                                    " " +
                                    datosCirujia[i].numeroQuirofano.toString() +
                                    " " +
                                    datosCirujia[i].nombreCirujano.toString() +
                                    " " +
                                    datosCirujia[i].fechaCirujia.toString() +
                                    " " +
                                    datosCirujia[i].horaInicio.toString() +
                                    " " +
                                    datosCirujia[i].estado.toString());
                              }*/

                              /*for (var i = 0; i < datosCirujia.length; i++) {
                                if (datosCirujia[i].estado == "Ocupado") {
                                  print("Ocupado");
                                  break;
                                } else {
                                  print("Libre");
                                  break;
                                }
                              }*/

                              if (datosCirujia[index].estado == "Ocupado") {
                                print("Ocupado");
                              } else {
                                print("Libre");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            RegisterPage(
                                              numeroQuirofano:
                                                  datosCirujia[index]
                                                      .numeroQuirofano,
                                              nombreCirujano: UserService
                                                  .nombreCompletoUsuarioLogueado,
                                              fechaCirujia: datosCirujia[index]
                                                  .fechaCirujia,
                                              horaInicio: datosCirujia[index]
                                                  .horaInicio,
                                            )));
                              }
                              // print(index);
                              /*for (var i = 0; i < indices.length; i++) {
                                if (indices[i] == index) {
                                  print("Ocupado");

                                  break;
                                } else if (indices[i] != index) {
                                  print("Libre");
                                  Preferences preferences = new Preferences();
                                  // Navigator.of(context).pushNamed('/tabla');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              RegisterPage(
                                                numeroQuirofano: nombreQuiro,
                                                nombreCirujano:
                                                    preferences.nombres,
                                                fechaCirujia: indices[1],
                                                horaInicio: 2,
                                              )));
                                  break;
                                }
                              }*/
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        responsive.diagonalPorcentaje(0.5)),
                                    child: Column(
                                      children: [
                                        Text(
                                          fechaConNegrita.text,
                                          style: TextStyle(
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.3),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        textosConFecha(
                                            index, valorFecha, responsive),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(
                                        responsive.diagonalPorcentaje(0.5)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          horaConNegrita.text,
                                          style: TextStyle(
                                              fontSize: responsive
                                                  .diagonalPorcentaje(1.3),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        textoConHora(
                                            index, valorHora, responsive),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                          responsive.diagonalPorcentaje(0.5)),
                                      child: Row(
                                        children: [
                                          Text(
                                            nombreDoctorConNegrita.text,
                                            style: TextStyle(
                                                fontSize: responsive
                                                    .diagonalPorcentaje(1.3),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          textoConNombreDoctor(index,
                                              valorNombreDoctor, responsive),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              color: colorBase,
                            )),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
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
    return Text(
      valor.text,
      style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.3)),
    );
  }

  Text tamanoLetraDiasSemana(
      int index, TextEditingController valor, Responsive responsive) {
    if (valor.text == "Lunes" ||
        valor.text == "Martes" ||
        valor.text == "Miercoles" ||
        valor.text == "Jueves" ||
        valor.text == "Viernes" ||
        valor.text == "Sabado" ||
        valor.text == "Domingo") {
      return Text(
        valor.text,
        style: TextStyle(
            fontSize: responsive.diagonalPorcentaje(2.2),
            fontWeight: FontWeight.bold),
      );
    }
  }

  Text textoConHora(
      int index, TextEditingController valor, Responsive responsive) {
    return Text(
      valor.text,
      style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.3)),
    );
  }

  Text textoConNombreDoctor(
      int index, TextEditingController valor, Responsive responsive) {
    return Text(
      valor.text,
      style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.3)),
    );
  }

  int cont1 = 1;
  String cargarFechasTabla(DateTime fechaActual, int index) {
    //La fecha que entra es la actual
    DateTime fechaAuxiliar;
    int contauxi = 1;

    do {
      fechaAuxiliar = new DateTime(
          fechaActual.year, fechaActual.month, fechaActual.day - contauxi);
      //Se disminuye en un dia mientras la fecha sea diferente de Lunes
      contauxi = contauxi + 1;

      fechaConNegrita.text = "";
    } while (DateFormat('EEEE').format(fechaAuxiliar).toString() != "Sunday");

    var fechaFinal = new DateTime(
        fechaAuxiliar.year, fechaAuxiliar.month, fechaAuxiliar.day + cont1);

    var format = new DateFormat("yyyy/MM/dd");
    var dateString = format.format(fechaFinal);
    fechaConNegrita.text = "Fecha: ";

    cont1++;
    if (cont1 == 8) {
      //Cuando llega a 5 dias el contador regresa a 0 para que repita este proceso en todo
      //el calendario
      cont1 = 1;
    }
    return dateString;
  }

  int cont = 0;
  int val = 7; // hora en que inicia el calendario

  String cargarHorasTabla(int index) {
    String enviarHoraFinal;

    // en esta parte se controla que valla cargando las horas solo de lunes a domingo
    enviarHoraFinal = (val).toString() + ":00";
    horaConNegrita.text = "Hora: ";
    cont++;

    if (cont == 7) {
      // cuando el contador de dias de la semana llega a 7 este se reinicia y el valor de la hora se eincrementa en 1
      cont = 0;
      val = val + 1;
    }

    return enviarHoraFinal;
  }

  TextEditingController colorBaseQuirofanosVacios(int index) {
    valorFecha.text = "";
    colorBase = Colors.blue[50];

    return valorFecha;
  }

  void diasSemana(int index) {
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
    } else if (index == 5) {
      valorFecha.text = "Sabado";
      colorBase = Colors.blue[400];
    } else if (index == 6) {
      valorFecha.text = "Domingo";
      colorBase = Colors.blue[400];
    }
  }

  void pintarQuirofanosOcupados(
      int index, String fecha, String hora, int numeroQuirofano) {
    DatosCirujia datosCiru = new DatosCirujia();
    datosCiru.indice = index;
    datosCiru.numeroQuirofano = null;
    datosCiru.nombreCirujano = "No Asignado";
    String fechaParseada = fecha.replaceAll("/", "-");
    datosCiru.fechaCirujia = DateTime.parse(fechaParseada);
    String horaFormulario = hora.replaceAll(":00", "");
    datosCiru.horaInicio = horaFormulario;
    datosCiru.estado = "Libre";
    datosCirujia.add(datosCiru);

    String horaInicio;
    String horaFin;
    int horaIntermediaAuxiliar;
    DateTime auxFecha;
    try {
      if (numeroQuirofano == 1) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          datosCirujia[index].numeroQuirofano = numeroQuirofano;
          if (CirujiaDAO.recibir[i].quirofano == 1) {
            horaInicio = CirujiaDAO.recibir[i].horaInicio;
            horaFin = CirujiaDAO.recibir[i].horaFin;
            auxFecha = new DateTime.fromMillisecondsSinceEpoch(
                CirujiaDAO.recibir[i].fechaCirujia);

            //print(CirujiaDAO.recibir[i].fechaCirujia);

            var format = new DateFormat("yyyy/MM/dd");
            var dateString = format.format(auxFecha);

            horaIntermediaAuxiliar = int.parse(CirujiaDAO.recibir[i].duracion);

            String horaParaUso = horaInicio.replaceAll(":00", "");
            int horaParaUsoInt = int.parse(horaParaUso);
            // print(CirujiaDAO.recibir[i].doctores[0].nombres + "ide del doctor");
            // print(auxFecha);
            for (var j = 0; j < horaIntermediaAuxiliar; j++) {
              //print("Variable Fecha: " + fecha); //variable que contiene los dias de la semana
              //print("Variable dateString: " +
              // dateString); // variable que contiene los dias de la base
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
                datosCirujia[index].estado = "Ocupado";
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[i].doctores[0].nombres;
                datosCirujia[index].nombreCirujano = valorNombreDoctor.text +
                    CirujiaDAO.recibir[i].doctores[0].apellidos;
                nombreDoctorConNegrita.text = "Dr: ";
              } else {
                datosCirujia[index].estado = "Libre";
                valorNombreDoctor.text = "";
                nombreDoctorConNegrita.text = "";
              }
            }
          }
        }
      } else if (numeroQuirofano == 2) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          datosCirujia[index].numeroQuirofano = numeroQuirofano;
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

            for (var j = 0; j < horaIntermediaAuxiliar; j++) {
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
                datosCirujia[index].estado = "Ocupado";
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[i].doctores[0].nombres;
                nombreDoctorConNegrita.text = "Dr: ";
                indices.add(index);
              } else {
                datosCirujia[index].estado = "Libre";
                valorNombreDoctor.text = "";
                nombreDoctorConNegrita.text = "";
              }
            }
          }
        }
      } else if (numeroQuirofano == 3) {
        for (var i = 0; i < CirujiaDAO.recibir.length; i++) {
          datosCirujia[index].numeroQuirofano = numeroQuirofano;
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

            for (var j = 0; j < horaIntermediaAuxiliar; j++) {
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
                datosCirujia[index].estado = "Ocupado";
                valorNombreDoctor.text =
                    CirujiaDAO.recibir[i].doctores[0].nombres;
                nombreDoctorConNegrita.text = "Dr: ";
              } else {
                datosCirujia[index].estado = "Libre";
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
      print("Llego al quiro:" + nombreQuirofano.toString());
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
