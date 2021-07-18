import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/admin/administracion.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/utils/responsive.dart';

class PrinciAdmi extends StatefulWidget {
  int numeroQuirofano;
  PrinciAdmi({Key key, this.numeroQuirofano = 1}) : super(key: key);

  @override
  _PrinciAdmiState createState() => _PrinciAdmiState();
}

class _PrinciAdmiState extends State<PrinciAdmi> {
  int numeroQui;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
    numeroQui = (widget.numeroQuirofano == 1) ? 1 : widget.numeroQuirofano;
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                /* CupertinoButton(
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 5)
                        ]),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrinciAdmi(
                                    numeroQuirofano: numeroQui,
                                  )));
                    });
                  },
                ),*/
              ],
            ),
            Container(
              height: 500,
              child: Administracion(
                numeroQuirofano: numeroQui,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
