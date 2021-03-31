import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/validations/usuarioLogueado.dart';

class Horarios extends StatelessWidget {
  UsuarioLogueado usuariologueado = UsuarioLogueado();

  @override
  Widget build(BuildContext context) {
    List<Color> manyColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.brown,
      Colors.purple,
      Colors.orange,
      Colors.pink
    ];
    List<Widget> myRowChildren = [];
    List<List<int>> numbers = [];
    List<int> columnNumbers = [];
    int z = 0;
    for (int i = 0; i <= 4; i++) {
      int maxColNr = 9;
      for (int y = 0; y <= maxColNr; y++) {
        int currentNumber = z + y; // 0,1,2,3,4,5,6,7,8,9,10, 10,11, 12, 13,14
        columnNumbers.add(currentNumber);
      }
      z += maxColNr;
      numbers.add(columnNumbers);
      columnNumbers = [];
    }
    print(numbers);

    myRowChildren = numbers
        .map(
          (columns) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: columns.map((nr) {
              int min = 0;
              int max = manyColors.length;
              Random rnd = new Random();
              int randomNumber = min + rnd.nextInt(max - min);
              return Container(
                padding: EdgeInsets.all(10),
                color: manyColors[randomNumber],
                child: Text(
                  nr.toString(),
                ),
              );
            }).toList(),
          ),
        )
        .toList();

    List<Widget> _buildCells(int count) {
      return List.generate(
        count,
        (index) => Container(
          alignment: Alignment.center,
          width: 120.0,
          height: 60.0,
          color: Colors.white,
          margin: EdgeInsets.all(4.0),
          child: Text(generar(), style: Theme.of(context).textTheme.title),
        ),
      );
    }

    List<Widget> _buildRows(int count) {
      return List.generate(
        count,
        (index) => Row(
          children: _buildCells(12),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildCells(5),
            ),
            Flexible(
              child: Container(
                height: 400,
                width: 400,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          /*Row(
                            
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: myRowChildren,
                          ),*/
                          DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Lunes',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Martes',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Miercoles',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Jueves',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Viernes',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                      Container(
                                        color: Colors.amber,
                                      ), onTap: () {
                                    print("valor");
                                  }),
                                  DataCell(
                                      Container(
                                        color: Colors.amber,
                                      ), onTap: () {
                                    print("valor");
                                  }),
                                  DataCell(
                                      Container(
                                        color: Colors.amber,
                                      ), onTap: () {
                                    print("valor");
                                  }),
                                  DataCell(
                                      Container(
                                        color: Colors.amber,
                                      ), onTap: () {
                                    print("valor");
                                  }),
                                  DataCell(
                                      Container(
                                        color: Colors.amber,
                                      ), onTap: () {
                                    print("valor");
                                  }),
                                ],
                              ),

                              /*  DataRow(cells: <DataCell>[
          DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                     _show();
                    },
                  ))
        ])*/
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String generar() {
    String nombre = "david";
    return nombre;
  }
}
