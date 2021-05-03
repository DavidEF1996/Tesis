import 'package:flutter/material.dart';

import 'package:qr_flutter/services/user_services.dart';

import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/utils/utils.dart' as utl;
import 'package:qr_flutter/vistas/vistaCelularLoguin.dart';

class LoginPage extends StatefulWidget {
  final String usuario;
  final String contrasena;

  const LoginPage({Key key, this.usuario = "", this.contrasena = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  double width;
  double height;
  final UserService httpServicio = UserService();
  Vista_Celular_Loguin vista = Vista_Celular_Loguin();
  @override
  void initState() {
    super.initState();
    nameController.text = (widget.usuario == "") ? "" : widget.usuario;
    passwordController.text =
        (widget.usuario == "") ? "" : utl.decode(widget.contrasena);
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final data = MediaQuery.of(context);

    if (data.orientation == Orientation.portrait) {
      return Scaffold(
          body: SingleChildScrollView(
        child: vista.vistaPortraitCelular(context, nameController,
            passwordController, httpServicio, responsive),
      ));
    } else {
      return Scaffold(
          body: vista.vistaLandScapeCelular(responsive, context, nameController,
              passwordController, httpServicio));
    }
  }
}
