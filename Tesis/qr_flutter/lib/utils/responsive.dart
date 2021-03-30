import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart' show required;
import 'dart:math' as math;

class Responsive {
  final double ancho, alto, diagonal;

  Responsive(
      {@required this.ancho, @required this.alto, @required this.diagonal});
  static Responsive of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    //calculo de la diagonal
    final diagonal =
        math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(ancho: size.width, alto: size.height, diagonal: diagonal);
  }

  double anchoPorcentaje(double porcentaje) {
    return this.ancho * porcentaje / 100;
  }

  double altoPorcentaje(double porcentaje) {
    return this.alto * porcentaje / 100;
  }

  double diagonalPorcentaje(double porcentaje) {
    return this.diagonal * porcentaje / 100;
  }
}
