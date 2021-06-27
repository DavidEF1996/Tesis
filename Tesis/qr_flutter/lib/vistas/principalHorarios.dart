import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/src/horarios.dart';
import 'package:qr_flutter/src/horariosPortrait.dart';
import 'package:qr_flutter/utils/fechas_tabla.dart';
import 'package:qr_flutter/utils/responsive.dart';

class PrincipalHorarios extends StatefulWidget {
  int parametroCreacion;

  @override
  _PrincipalHorariosState createState() => _PrincipalHorariosState();
}

class _PrincipalHorariosState extends State<PrincipalHorarios> {
  bool _isLoading = false;
  CirujiaDAO get service => GetIt.I<CirujiaDAO>();
  APIResponse<List<Cirujias>> _apiResponse;

  List<DateTime> fechas = [];
  Fecha_Tabla fecha_tabla = new Fecha_Tabla();
  DateTime fechaActual = DateTime.now();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    cargarHijos();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  cargarHijos() async {
    setState(() {
      _isLoading = true;
    });
    CirujiaDAO cirujia = new CirujiaDAO();
    fechas = fecha_tabla.obtenerFechasSemana(fechaActual);
    _apiResponse = await cirujia.obtenerCirujias(fechas[0], fechas[4]);

    setState(() {
      _isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    if (data.orientation == Orientation.portrait) {
      return Scaffold(

          // drawer: MenuLateral(),
          body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(
                      0.7, 0), // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color.fromRGBO(28, 26, 24, 1),
                    const Color.fromRGBO(28, 26, 24, 1),
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: Column(
                children: [
                  /*Container(
                  child: Text(
                    "Noticias",
                    style: TextStyle(
                        fontSize: responsive.diagonalPorcentaje(5),
                        color: Color.fromRGBO(255, 226, 199, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),*/
                  Expanded(
                    child: HorariosPortrait(),
                  )
                ],
              ),
            );
          }
        },
      ));
    } else {
      return Scaffold(

          // drawer: MenuLateral(),
          body: Builder(
        builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(
                      0.7, 0), // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color.fromRGBO(28, 26, 24, 1),
                    const Color.fromRGBO(28, 26, 24, 1),
                  ], // red to yellow
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: Column(
                children: [
                  /*Container(
                  child: Text(
                    "Noticias",
                    style: TextStyle(
                        fontSize: responsive.diagonalPorcentaje(5),
                        color: Color.fromRGBO(255, 226, 199, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),*/
                  Expanded(
                    child: Horarios(),
                  )
                ],
              ),
            );
          }
        },
      ));
    }
  }
}

// List<Noticias> noticias = Noticias.noticias_album();
