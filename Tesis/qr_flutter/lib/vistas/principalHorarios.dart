import 'package:flutter/material.dart';
import 'package:qr_flutter/src/horarios.dart';
import 'package:qr_flutter/utils/responsive.dart';


class PrincipalHorarios extends StatelessWidget {
 // List<Noticias> noticias = Noticias.noticias_album();

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
     
     // drawer: MenuLateral(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:
                Alignment(0.7, 0), // 10% of the width, so there are ten blinds.
            colors: [
              const Color.fromRGBO(28, 26, 24, 1),
              const Color.fromRGBO(28, 26, 24, 1),
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
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
      ),
    );
  }
}
