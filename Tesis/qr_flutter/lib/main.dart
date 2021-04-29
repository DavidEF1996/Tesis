import "package:flutter/material.dart";
import 'package:qr_flutter/dao/cirujiaDao.dart';
import 'package:qr_flutter/preferences/preferences.dart';

import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/login.dart';

import 'package:qr_flutter/utils/rutas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _preferences = new Preferences();
  await _preferences.initPreferences();

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
        home: (_preferences.id == "") ? Botones() : Botones(),
        routes: builAppRoutes());
  }
}
