import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/src/registro_usuarios.dart';

class Botones extends StatelessWidget {
  TextStyle estiloTexto = new TextStyle(fontSize: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Image(
          image: AssetImage('assets/logoOperation.PNG'),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 100.0),
              MaterialButton(
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {
                  _submit((context));
                },
                color: Colors.lightBlue,
                child: Text('Registro de Paciente',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {
                  final route = MaterialPageRoute(builder: (context) {
                    return insertar_usuarios();
                  });
                  Navigator.push(context, route);
                },
                color: Colors.lightBlue,
                child:
                    Text('Quirofanos', style: TextStyle(color: Colors.white)),
              ),
              MaterialButton(
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {
                  final _preferences = new Preferences();
                  _preferences.id = "";
                  final route = MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  });
                  Navigator.pushReplacement(context, route);
                },
                color: Colors.lightBlue,
                child: Text('Salir', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Future _submit(BuildContext context) async {
    Navigator.of(context).pushNamed('/tabla');
  }
}
