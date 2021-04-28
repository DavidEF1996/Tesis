import 'package:flutter/material.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/horarios.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/utils/responsive.dart';

class Vista_celular {
  CirujiaDAO cirujiaDao = new CirujiaDAO();
  Container vistaPortraitCelular(Responsive responsive, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            height: responsive.altoPorcentaje(25),
            width: responsive.ancho,
            child: Image(
              width: responsive.diagonalPorcentaje(60),
              alignment: Alignment.topCenter,
              image: AssetImage('assets/logoOperation.PNG'),
            ),
          ),
          Container(
              child: Column(
            children: [
              Container(
                padding: new EdgeInsets.all(10.0),
                height: responsive.diagonalPorcentaje(13),
                width: responsive.diagonalPorcentaje(40),
                child: FloatingActionButton.extended(
                  heroTag: "btn1",
                  backgroundColor: Colors.teal,
                  label: Text(
                    'Registro de Pacientes',
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: Icon(Icons.crop_square),
                  onPressed: () {
                    _submit((context));
                  },
                ),
              ),
              Container(
                padding: new EdgeInsets.all(10.0),
                height: responsive.diagonalPorcentaje(13),
                width: responsive.diagonalPorcentaje(40),
                child: FloatingActionButton.extended(
                  heroTag: "btn2",
                  backgroundColor: Colors.teal,
                  label: Text(
                    'Tabla                            ',
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: Icon(Icons.crop_square),
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      return Horarios();
                    });
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
              Container(
                padding: new EdgeInsets.all(10.0),
                height: responsive.diagonalPorcentaje(13),
                width: responsive.diagonalPorcentaje(40),
                child: FloatingActionButton.extended(
                  heroTag: "btn3",
                  backgroundColor: Colors.teal,
                  label: Text(
                    'Salir                             ',
                    style: TextStyle(fontSize: 20),
                  ),
                  icon: Icon(Icons.crop_square),
                  onPressed: () {
                    final _preferences = new Preferences();
                    _preferences.id = "";
                    final route = MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    });
                    Navigator.pushReplacement(context, route);
                  },
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Container vistaLandScapeCelular(Responsive responsive, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Image(
                width: responsive.diagonalPorcentaje(50),
                alignment: Alignment.topCenter,
                image: AssetImage('assets/logoOperation.PNG'),
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
                child: Column(
              children: [
                Container(
                  padding: new EdgeInsets.all(10.0),
                  height: responsive.diagonalPorcentaje(13),
                  width: responsive.diagonalPorcentaje(40),
                  child: FloatingActionButton.extended(
                    heroTag: "btn1",
                    backgroundColor: Colors.teal,
                    label: Text(
                      'Registro de Pacientes',
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: Icon(Icons.crop_square),
                    onPressed: () {
                      _submit((context));
                    },
                  ),
                ),
                Container(
                  padding: new EdgeInsets.all(10.0),
                  height: responsive.diagonalPorcentaje(13),
                  width: responsive.diagonalPorcentaje(40),
                  child: FloatingActionButton.extended(
                    heroTag: "btn2",
                    backgroundColor: Colors.teal,
                    label: Text(
                      'Tabla                            ',
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: Icon(Icons.crop_square),
                    onPressed: () {
                      cirujiaDao.obtenerCirujias();
                      final route = MaterialPageRoute(builder: (context) {
                        return Horarios();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                ),
                Container(
                  padding: new EdgeInsets.all(10.0),
                  height: responsive.diagonalPorcentaje(13),
                  width: responsive.diagonalPorcentaje(40),
                  child: FloatingActionButton.extended(
                    heroTag: "btn3",
                    backgroundColor: Colors.teal,
                    label: Text(
                      'Salir                             ',
                      style: TextStyle(fontSize: 20),
                    ),
                    icon: Icon(Icons.crop_square),
                    onPressed: () {
                      final _preferences = new Preferences();
                      _preferences.id = "";
                      final route = MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                ),
              ],
            )),
          )),
        ],
      ),
    );
  }

  Future _submit(BuildContext context) async {
    Navigator.of(context).pushNamed('/tabla');
  }
}
