import "package:flutter/material.dart";
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/login.dart';

import 'package:qr_flutter/utils/rutas.dart';
import 'package:qr_flutter/vistas/PrincipalTarjetasCirujia.dart';
import 'package:qr_flutter/vistas/principalHorarios.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => CirujiaDAO());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = new Preferences();
  await _preferences.initPreferences();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Widget routePage = LoginPage();
    final _preferences = new Preferences();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: (_preferences.id == "") ? LoginPage() : PrincipalTarCirujias(),
        routes: builAppRoutes());
  }
}
