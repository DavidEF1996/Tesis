import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/admin/horariosAdmi.dart';
import 'package:qr_flutter/admin/principalAdmi.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/preferences/preferences.dart';

import 'package:qr_flutter/utils/fechas_tabla.dart';
import 'package:qr_flutter/utils/responsive.dart';

class Administracion extends StatefulWidget {
  int numeroQuirofano;
  int diasIncremento;
  Administracion({Key key, this.numeroQuirofano = 1, this.diasIncremento})
      : super(key: key);

  @override
  _AdministracionState createState() => _AdministracionState();
}

class _AdministracionState extends State<Administracion> {
  int enviarNumero;
  bool isButtonClickable;
  DateTime currentDate = DateTime.now();
  DateTime fechaActual = DateTime.now();
  DateTime fechasPorSemana;
  int incrementarDias;

  @override
  void initState() {
    super.initState();
    enviarNumero = (widget.numeroQuirofano == 1) ? 1 : widget.numeroQuirofano;
    isButtonClickable = true;
    incrementarDias =
        (widget.diasIncremento == null) ? 0 : widget.diasIncremento;
    fechasPorSemana = new DateTime(
        fechaActual.year, fechaActual.month, fechaActual.day + incrementarDias);
    // print("La fecha que llega: " + fechaActual.toString());
    //print("El incremento de dias es:" + incrementarDias.toString());
    print("La nueva fecha es: " + fechasPorSemana.toString());
  }

  void ocultarBoton() {
    setState(() {
      isButtonClickable = false;
      print("Clicked Once");
    });
  }

  void mostrarBoton() {
    setState(() {
      isButtonClickable = true;
      print("Clicked Once");
    });
  }

  TextEditingController nuevaFecha = new TextEditingController();
  List<DateTime> fechas = [];
  Fecha_Tabla fecha_tabla = new Fecha_Tabla();
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    CirujiaDAO cirujia = new CirujiaDAO();

    APIResponse<List<Cirujias>> _apiResponse;
    fechas = fecha_tabla.obtenerFechasSemana(fechasPorSemana);
    //  _apiResponse = await cirujia.obtenerCirujias(fechas[0], fechas[4]);
    return FutureBuilder(
      future: cirujia.obtenerCirujias(fechas[0], fechas[4]),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
                color: Colors.white10,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(responsive.diagonalPorcentaje(1)),
                      child: Text(
                        "Panel de Administración",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(2.8),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isButtonClickable,
                          child: Column(
                            children: [
                              SizedBox(
                                height: responsive.diagonalPorcentaje(2),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                    responsive.diagonalPorcentaje(1)),
                                alignment: Alignment.topLeft,
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        text: "Fecha:   ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)),
                                        children: <TextSpan>[
                                          /*TextSpan(
                                            text: fecha(CirujiaDAO
                                                .recibir[0].fechaCirujia),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'raleway',
                                                fontSize: responsive
                                                    .diagonalPorcentaje(1.7)),
                                          )*/
                                        ])),
                              ),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(1.5),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                    responsive.diagonalPorcentaje(1)),
                                child: RichText(
                                    text: TextSpan(
                                        text: "Hora  Inicio:      ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)),
                                        children: <TextSpan>[
                                      /* TextSpan(
                                        text: CirujiaDAO.recibir[0].horaInicio,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.7)),
                                      )*/
                                    ])),
                              ),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(1.5),
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                    responsive.diagonalPorcentaje(1)),
                                alignment: Alignment.topLeft,
                                child: RichText(
                                    text: TextSpan(
                                        text: "Hora Fin:           ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)),
                                        children: <TextSpan>[
                                      /* TextSpan(
                                        text: CirujiaDAO.recibir[0].horaFin,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.7)),
                                      )*/
                                    ])),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: responsive.diagonalPorcentaje(3.5),
                        ),
                        Visibility(
                          visible: isButtonClickable,
                          child: Column(
                            children: [
                              Container(
                                  child: Row(
                                children: [
                                  Text(
                                    "Fecha nueva: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'raleway',
                                        fontSize:
                                            responsive.diagonalPorcentaje(1.8)),
                                  ),
                                  SizedBox(
                                    width: responsive.diagonalPorcentaje(1.5),
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              currentDate.year.toString() +
                                                  "/" +
                                                  currentDate.month.toString() +
                                                  "/" +
                                                  currentDate.day.toString(),
                                              style: TextStyle(
                                                  fontSize: responsive
                                                      .diagonalPorcentaje(1.7),
                                                  fontFamily: 'raleway'),
                                            ),
                                            IconButton(
                                              onPressed: () =>
                                                  selectDateProcess(context),
                                              icon: Icon(Icons.date_range),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              Container(
                                  child: Row(
                                children: [
                                  Text(
                                    "Hora Inicio: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'raleway',
                                        fontSize:
                                            responsive.diagonalPorcentaje(1.8)),
                                  ),
                                  SizedBox(
                                    width: responsive.diagonalPorcentaje(1.5),
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      width: responsive.diagonalPorcentaje(15),
                                      height: responsive.diagonalPorcentaje(4),
                                      child: TextField(
                                        style: TextStyle(
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.5),
                                            height: 1),
                                        cursorColor: Colors.black,
                                        controller: nuevaFecha,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                              SizedBox(
                                height: responsive.diagonalPorcentaje(1.5),
                              ),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    children: [
                                      Text(
                                        "Hora Fin:     ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'raleway',
                                            fontSize: responsive
                                                .diagonalPorcentaje(1.8)),
                                      ),
                                      SizedBox(
                                        width:
                                            responsive.diagonalPorcentaje(1.5),
                                      ),
                                      SingleChildScrollView(
                                        child: Container(
                                          width:
                                              responsive.diagonalPorcentaje(15),
                                          height:
                                              responsive.diagonalPorcentaje(4),
                                          child: TextField(
                                            style: TextStyle(
                                                fontSize: responsive
                                                    .diagonalPorcentaje(1.5),
                                                height: 1),
                                            cursorColor: Colors.black,
                                            controller: nuevaFecha,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 10),
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: responsive.diagonalPorcentaje(2),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: responsive.diagonalPorcentaje(3.5),
                            ),
                            Visibility(
                              visible: isButtonClickable,
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  child: Text(
                                    "Actualizar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'sans',
                                        letterSpacing: 1,
                                        fontSize: 10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 3)
                                      ]),
                                ),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PrinciAdmi(
                                                  numeroQuirofano: enviarNumero,
                                                )));
                                  });
                                },
                              ),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                child: Text(
                                  "Cancelar  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sans',
                                      letterSpacing: 1,
                                      fontSize: 10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 3)
                                    ]),
                              ),
                              onPressed: () {
                                setState(() {
                                  ocultarBoton();
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 75,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                child: Text(
                                  "Anterior  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sans',
                                      letterSpacing: 1,
                                      fontSize: 10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 3)
                                    ]),
                              ),
                              onPressed: () {
                                setState(() {
                                  final _preferences = new Preferences();
                                  int incremento = _preferences.incrementoDias;
                                  int enviar =
                                      actualizarDecrementos(incremento);
                                  print("El valor a enviar es: " +
                                      enviar.toString());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Administracion(
                                              numeroQuirofano: enviarNumero,
                                              diasIncremento: enviar)));
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: Horarios(
                              nombreQuirofano: enviarNumero,
                              fecha: fechasPorSemana,
                            ),
                          ),
                          Container(
                            width: 75,
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Container(
                                child: Text(
                                  "Siguiente  ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'sans',
                                      letterSpacing: 1,
                                      fontSize: 10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 3)
                                    ]),
                              ),
                              onPressed: () {
                                setState(() {
                                  final _preferences = new Preferences();
                                  int incremento = _preferences.incrementoDias;
                                  int enviar =
                                      actualizarIncrementos(incremento);
                                  print("El valor a enviar es: " +
                                      enviar.toString());
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Administracion(
                                              numeroQuirofano: enviarNumero,
                                              diasIncremento: enviar)));
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          );
        }
      },
    );
  }

  String fecha(int tiempo) {
    print(tiempo);
    var date = new DateTime.fromMillisecondsSinceEpoch(tiempo);
    String fecha = date.toString();
    String enviar = fecha.substring(0, 10);
    return enviar;
  }

  DateTime fechAux = DateTime.now();
  Future<void> selectDateProcess(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(fechAux.year, fechAux.month, fechAux.day),
        lastDate: DateTime(fechAux.year, fechAux.month, fechAux.day + 8));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  int actualizarIncrementos(int incremento) {
    final _preferences = new Preferences();
    int aux = incremento;

    if (aux == null) {
      aux = 7;
      _preferences.incrementoDias = aux;
    } else if (aux <= 21) {
      aux = aux + 7;
      _preferences.incrementoDias = aux;
    } else {
      return aux;
    }
    return aux;
  }

  int actualizarDecrementos(int incremento) {
    final _preferences = new Preferences();
    int aux = incremento;

    if (aux == null) {
      return aux;
    } else if (aux == 0) {
      return aux;
    } else if (aux > 0) {
      aux = aux - 7;
      _preferences.incrementoDias = aux;
    }
    return aux;
  }
}
