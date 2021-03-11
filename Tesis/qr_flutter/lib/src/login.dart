import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/services/user_services.dart';
import 'package:qr_flutter/src/cambioContrasena.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/registro_usuarios.dart';
import 'package:qr_flutter/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final String usuario;
  final String contrasena;

  const LoginPage({Key key, this.usuario = "", this.contrasena = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

Widget portraitView() {
  // Return Your Widget View Here Which you want to Load on Portrait Orientation.
  return Container(
      width: 300.00,
      color: Colors.green,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text(' Portrait View Detected. ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white)));
}

Widget landscapeView() {
  // // Return Your Widget View Here Which you want to Load on Landscape Orientation.
  return Container(
      width: 300.00,
      color: Colors.pink,
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text(' Landscape View Detected.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, color: Colors.white)));
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final UserService httpServicio = UserService();
  @override
  void initState() {
    super.initState();
    nameController.text = (widget.usuario == "") ? "" : widget.usuario;
    passwordController.text = (widget.usuario == "") ? "" : widget.contrasena;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/logoOperation.PNG'),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Bienvenido',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Usuario",
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Contraseña",
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    final route = MaterialPageRoute(builder: (context) {
                      //return CambioContrasena();
                    });
                    Navigator.push(context, route);
                  },
                  textColor: Colors.blue,
                  child: Text('Olvido su contraseña'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Comenzar'),
                      onPressed: () {
                        cargar(context);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('¿No tiene una cuenta?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Crear cuenta',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        final route = MaterialPageRoute(builder: (context) {
                          return insertar_usuarios();
                        });
                        Navigator.push(context, route);
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  Future cargar(BuildContext context) async {
    final String usuario = nameController.text;
    final String contrasena = passwordController.text;

    final result = await httpServicio.loginUsuario(usuario, contrasena);
    print(result);
    print((result['acceso']));
    if (result['acceso']) {
      if (result['bandera'] == 0) {
        final route = MaterialPageRoute(builder: (context) {
          return CambioContrasena(result['idDoctor']);
        });
        Navigator.push(context, route);
      } else {
        //print(result['idDoctor']);

        final _preferences = new Preferences();
        _preferences.id = result['idDoctor'];
        final route = MaterialPageRoute(builder: (context) {
          return Botones();
        });
        Navigator.push(context, route);
      }
    } else {
      mostrarAlerta(context, "Error de usuario");
    }

    //

    //print("object");
    //Usuario1 usu = result.data;
    //print(usu.user);
  }
}
