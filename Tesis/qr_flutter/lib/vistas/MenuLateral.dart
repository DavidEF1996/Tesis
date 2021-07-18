import 'package:flutter/material.dart';
import 'package:qr_flutter/admin/principalAdmi.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';
import 'package:qr_flutter/validations/cabecera.dart';
import 'package:qr_flutter/vistas/principalHorarios.dart';

class MenuLateral extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Drawer(
        child: Container(
          color: Color.fromRGBO(255, 226, 199, 1),
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              new UserAccountsDrawerHeader(
                  accountName: Container(
                    alignment: Alignment.bottomLeft,
                    child: Cabecera(),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(101, 91, 80, 0.80),
                      image: DecorationImage(
                        image: AssetImage('assets/logo2.png'),
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      ))),
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Registro de Cirujia"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => RegisterPage(
                                  numeroQuirofano: null,
                                  nombreCirujano: "",
                                  fechaCirujia: null,
                                  horaInicio: "8",
                                )));
                  },
                ),
              ),
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Horarios de Cirujias"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new PrincipalHorarios(),
                      ),
                    );
                  },
                ),
              ),
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Administración"),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new PrinciAdmi(),
                      ),
                    );
                  },
                ),
              ),
              Ink(
                color: Colors.blue,
                child: ListTile(
                  title: Text("Salir"),
                  onTap: () {
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
          ),
        ),
      ),
    );
  }
}
