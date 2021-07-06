import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/dao/reglas.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';
import 'package:qr_flutter/utils/VariablesGlobales.dart';

class ComboBox extends StatefulWidget {
  final String catgoria;
  ComboBox({Key key, this.catgoria}) : super(key: key);

  @override
  _ComboBoxState createState() => _ComboBoxState();
}

ReglasDao rdao = ReglasDao();
bool autorizacion = true;

class _ComboBoxState extends State<ComboBox> {
  String catg = "";
  int _horasInicio = 8;
  int horaFin;
  int _minutosInicio = 0;

  @override
  void initState() {
    super.initState();
    final _preferences = new Preferences();
    autorizacion = _preferences.autorizacion;
    catg = (widget.catgoria == "") ? "privada" : widget.catgoria;
    print("La categoria que llega es: " + catg);
  }

  @override
  Widget build(BuildContext context) {
    final _preferences = new Preferences();
    return FutureBuilder(
        future: rdao.reglaTipoCirujia(catg),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return contenedor(autorizacion);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  String tipoCirujia2 = 'cirujia';
  var eleccionRadioButton2;
  Container crearRadio2(String value, String text) {
    return Container(
      width: 145,
      child: Row(
        children: [
          Radio(
            value: value,
            toggleable: false,
            groupValue: tipoCirujia2,
            onChanged: (value) {
              setState(() {
                tipoCirujia2 = value;
                eleccionRadioButton2 = value;
                VariablesGlobales.tipoCirujia = tipoCirujia2;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container contenedor(bool respuesta) {
    if (respuesta) {
      return Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            child: Text(
                              "Privada",
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
                                      color: Colors.black26, blurRadius: 5)
                                ]),
                          ),
                          onPressed: () {
                            setState(() {
                              catg = "privada";
                              VariablesGlobales.limiteRegistroCirujia = 24;
                              VariablesGlobales.comienzoRegistroCirujia = 1;

                              _horasInicio = 8;
                              VariablesGlobales.redCujia = "privada";
                            });
                          },
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            child: Text(
                              "Publica",
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
                                      color: Colors.black26, blurRadius: 5)
                                ]),
                          ),
                          onPressed: () {
                            setState(() {
                              catg = "rpis";
                              VariablesGlobales.limiteRegistroCirujia = 17;
                              VariablesGlobales.comienzoRegistroCirujia = 14;

                              _horasInicio = 14;
                              VariablesGlobales.redCujia = "rpis";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        crearRadio2('emergencia', 'Emergencia'),
                        crearRadio2('emergenciaDiferible', 'E. Diferible'),
                        crearRadio2('electiva', 'Electiva'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Hora de Inicio:'),
                Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        itemHeight: 25,
                        value: _horasInicio,
                        minValue: VariablesGlobales.comienzoRegistroCirujia,
                        maxValue: VariablesGlobales.limiteRegistroCirujia,
                        textStyle: TextStyle(fontSize: 15, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        onChanged: (value) =>
                            setState(() => _horasInicio = value),
                      ),
                    ],
                  ),
                ),
                Text(':'),
                Container(
                  width: 50,
                  child: Column(
                    children: [
                      NumberPicker(
                        itemHeight: 25,
                        value: VariablesGlobales.minutosInicio,
                        minValue: 0,
                        maxValue: 60,
                        textStyle: TextStyle(fontSize: 15, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        onChanged: (value) => setState(
                            () => VariablesGlobales.minutosInicio = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            child: Text(
                              "Privada",
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
                                      color: Colors.black26, blurRadius: 5)
                                ]),
                          ),
                          onPressed: () {
                            setState(() {
                              catg = "privada";
                              VariablesGlobales.limiteRegistroCirujia = 24;
                              VariablesGlobales.comienzoRegistroCirujia = 1;

                              _horasInicio = 8;
                              VariablesGlobales.redCujia = "privada";
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        crearRadio2('emergencia', 'Emergencia'),
                        crearRadio2('emergenciaDiferible', 'E. Diferible'),
                        crearRadio2('electiva', 'Electiva'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Hora de Inicio:'),
                Container(
                  width: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        itemHeight: 25,
                        value: _horasInicio,
                        minValue: VariablesGlobales.comienzoRegistroCirujia,
                        maxValue: VariablesGlobales.limiteRegistroCirujia,
                        textStyle: TextStyle(fontSize: 15, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        onChanged: (value) =>
                            setState(() => _horasInicio = value),
                      ),
                    ],
                  ),
                ),
                Text(':'),
                Container(
                  width: 50,
                  child: Column(
                    children: [
                      NumberPicker(
                        itemHeight: 25,
                        value: VariablesGlobales.minutosInicio,
                        minValue: 0,
                        maxValue: 60,
                        textStyle: TextStyle(fontSize: 15, color: Colors.black),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        onChanged: (value) => setState(
                            () => VariablesGlobales.minutosInicio = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
