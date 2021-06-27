import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/model/modeloDatosCirujia.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/utils/ListaCirujiaTarjetas.dart';
import 'package:qr_flutter/utils/fechas_tabla.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/cabecera.dart';
import 'package:qr_flutter/vistas/MenuLateral.dart';

class PrincipalTarCirujias extends StatefulWidget {
  PrincipalTarCirujias({Key key}) : super(key: key);

  @override
  _PrincipalTarCirujiasState createState() => _PrincipalTarCirujiasState();
}

class _PrincipalTarCirujiasState extends State<PrincipalTarCirujias> {
  bool _isLoading = false;
  //List<DatosCirujia> noticias = DatosCirujia();
  List<DatosCirujia> datos = [];
  String categoria;
  Fecha_Tabla fecha_tabla = new Fecha_Tabla();
  List<DateTime> fechas = [];
  APIResponse<List<Cirujias>> _apiResponse;
  List<Cirujias> data = [];
  DateTime fechaActual = DateTime.now();

  @override
  initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    cargarNoticias();
    super.initState();
  }

  cargarNoticias() async {
    setState(() {
      _isLoading = true;
    });
    CirujiaDAO cirujia = new CirujiaDAO();
    print(Preferences().nombresCompletos);
    print(Preferences().apellidos);
    data = await cirujia.getCirujiasTarjetas(
        utf8.decode(latin1.encode(Preferences().nombresCompletos),
            allowMalformed: true),
        Preferences().apellidos,
        Preferences().id);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(UserService.usuariologueado);
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
                //usuariologueado.botonSalir(context),
              ],
            ),
          ),
        ),
        drawer: MenuLateral(),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              decoration: BoxDecoration(color: Colors.blue[200]),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      "Cirujias Pendientes",
                      style: TextStyle(
                          fontSize: responsive.diagonalPorcentaje(3.5),
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListNotices(
                      dataCirujia: data,
                    ),
                  )
                ],
              ),
            );
          }
        }));
  }
}
