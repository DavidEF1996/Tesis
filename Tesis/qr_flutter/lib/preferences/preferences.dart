import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET JSESSIONID
  get id {
    return _prefs.getString('id') ?? '';
    //return _prefs.getString('id');
  }

  // SET JSESSIONID
  set id(String id) {
    _prefs.setString('id', id);
  }

  get nombres {
    return _prefs.getString('nombre') ?? '';
  }

  set nombres(String nombres) {
    _prefs.setString('nombre', nombres);
  }

  get nombresCompletos {
    return _prefs.getString('nombres') ?? '';
  }

  set nombresCompletos(String nombres) {
    _prefs.setString('nombres', nombres);
  }

  get apellidos {
    return _prefs.getString('apellidos') ?? '';
  }

  set apellidos(String apellidos) {
    _prefs.setString('apellidos', apellidos);
  }

  get autorizacion {
    return _prefs.getBool("autorizar" ?? '');
  }

  set autorizacion(bool autorizar){
    _prefs.setBool("autorizar", autorizar);
  }
}
