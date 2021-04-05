/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with three columns: name, age, and
// role. The columns are defined by three [DataColumn] objects. The table
// contains three rows of data for three example users, the data for which
// is defined by three [DataRow] objects.
//
// ![](https://flutter.github.io/assets-for-api-docs/assets/material/data_table.png)

import 'package:flutter/material.dart';
import 'dart:core';

import 'package:qr_flutter/validations/usuarioLogueado.dart';

/// This is the stateless widget that the main application instantiates.
class Horarios extends StatefulWidget {
  const Horarios({Key key}) : super(key: key);

  @override
  _Horarios createState() => _Horarios();
}

class _Horarios extends State<Horarios> {
  @override
  UsuarioLogueado usuariologueado = UsuarioLogueado();
  int index = 1;
  Color colorBase;

  String nombreC;
  TextEditingController valorFecha = TextEditingController();
  TextEditingController valorHora = TextEditingController();

  DateTime fechaActual = DateTime.now();
  Widget build(BuildContext context) {
    final title = 'Grid List';

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
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 5,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(55, (index) {
            setState(() {
              _cabeceras(index);

              valorFecha.text = fechas(fechaActual, index);
              horas(fechaActual, index);

              pintarOcupados(index, valorFecha.text, valorHora.text);
            });
            // _valores(index);
            return Center(
                child: RaisedButton(
              child: Container(
                width: 200,
                child: Column(
                  children: [textos(index, valorFecha), Text(valorHora.text)],
                ),
              ),
              color: colorBase,
              onPressed: () {
                print("El texto: ");
                //  sacarTexto(index);
              },
            ));
          }),
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
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Text(
        valor.text,
        style: TextStyle(fontSize: 12),
      );
    }
  }

  void _show(int index, TextEditingController texto) {
    //if (index == 2) {
    //print("Son iguales" + fechaActual.year.toString());
    //fechas(fechaActual);
    //  }
    print("index = " + index.toString() + texto.text);
  }

  int cont1 = 0;
  int val1 = 0;
  String fechas(DateTime fecha, int index) {
    if (index > 4) {
      String enviarFecha = fecha.year.toString() +
          "/" +
          fecha.month.toString() +
          "/" +
          (fecha.day + cont1).toString();
      cont1++;
      if (cont >= 5) {
        cont = 0;
      }
      return enviarFecha;
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

  void pintarOcupados(int index, String fecha, String hora) {
    print(fecha);
    print(hora);

    if (fecha == "2021/4/10" && hora == "9") {
      colorBase = Colors.white;
    }

    if (fecha == "2021/4/15" && hora == "10") {
      colorBase = Colors.white;
    }
  }
}
